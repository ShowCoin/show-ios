# coding=utf-8
import httplib
import urllib
import json
import time
import getpass
import sys
import re;
import os

reload(sys)
sys.setdefaultencoding("utf-8")


# 获取脚本文件的当前路径
def currentFileDir():
    # 获取脚本路径
    path = sys.path[0]
    # 判断为脚本文件还是py2exe编译后的文件，如果是脚本文件，则返回的是脚本的目录，如果是py2exe编译后的文件，则返回的是编译后的文件路径
    if os.path.isdir(path):
        return path
    elif os.path.isfile(path):
        return os.path.dirname(path)
    pass

pass


def paramBundleStrFile(bundleStrFile):
    rtnDict = {};
    f = open(bundleStrFile, 'r');
    try:

        values = []
        print('进入循环')
        for line in f:
            print(line)
            m = re.match(r'\W*"(.*)"\W*=\W*"*(.*)("*\W*;)?', line)
            print(m)
            if m != None:
                if (rtnDict.has_key(m.group(1))):
                    raise Exception(bundleStrFile + ' repeated key: ' + m.group(1))
                else:
                    rtnDict[m.group(1)] = m.group(2);
                pass
            else:
                m = re.match(r'\s+<\w+>(.*)</\w+>', line)
                if m != None:
                    values.append(m.group(1))
                pass
            pass
        pass

        if len(values):
            for v in values:
                index = values.index(v)
                if index % 2 == 0:
                    rtnDict[v] = values[index+1]
                pass
            pass
        pass
    finally:
        f.close();
    pass
    return rtnDict;


pass


def generateImgNames(start_dir):
    os.chdir(start_dir)
    result = []
    for obj in os.listdir(os.curdir):
        if obj.endswith('.png'):
            name_str = obj.replace('.png','').replace('@2x', '').replace('@3x', '').replace(' ','_')
            if name_str not in result:
                result.append(name_str)
            pass
        pass
    pass
    os.chdir(os.pardir)  # !!!
    return result


pass


def compareBundleAndFileStr(bundleStrDict, fileStrDict):
    # 同步字符串
    print '\n\n\n==================== bundle 中比 server 多的==========================='
    # 字符串新增的key
    for key in bundleStrDict.keys():
        if (fileStrDict.has_key(key) == False):
            print 'app new key: ' + key
            print '              code: STRING_' + key.upper()
            print '              内容cn:' + bundleStrDict[key]
        pass
    pass

    print '\n\n\n==================== server 中比 bundle 多的==========================='

    # 字符串删除的key
    for key in fileStrDict.keys():
        if (bundleStrDict.has_key(key) == False):
            print 'product new key: ' + key
            print 'code: STRING_' + key.upper()
            print "内容cn:" + fileStrDict[key]
        pass
    pass

    print '\n\n\n====================        变更的        ==========================='

    #  变更的中文字符串
    for key in bundleStrDict.keys():
        if (fileStrDict.has_key(key)):
            if (bundleStrDict[key].decode() != fileStrDict[key]):
                print str("changed key: " + key + "\n(bundle)[" + bundleStrDict[key] + "]\n(server)[" + fileStrDict[
                    key] + "]\n");
                print str('changed key:' + key + '\n')
                pass
            pass
        pass
    pass


pass

def modifyConfigPch(tfile,sstr,rstr):
    try:
        lines=open(tfile,'r').readlines()
        flen=len(lines)-1
        for i in range(flen):
            if sstr in lines[i]:
                lines[i]=rstr
            pass
        pass
        open(tfile,'w').writelines(lines)
        
    except Exception,e:
        print e
pass

def printToHeaderFile(prefix, keys, outPutPath):
    fCnOut = open(outPutPath, "w");

#    # 输入前后的提示
#     stringTip = '\n\n/* \n    This text file was create automatic by loadStringFromServer.py \n        create time :'
#     stringTip += time.strftime('%Y-%m-%d(%A) %H:%M:%S',time.localtime(time.time()))
#     stringTip += '\n        create by :'
#     stringTip += getpass.getuser()
#     stringTip += '\n*/\n\n\n'

    print >> fCnOut  # ,stringTip

    keys.sort();

    for key in keys:
        print >> fCnOut, '#define  ' + prefix.upper() + '_' + key.upper() +'\t' + 'KRESOURCESSTRING('+'@"'  + key +'")'+ '\n'
    pass
    fCnOut.close()


pass


def printToPlistFile(fileStrDict, outPutPath):
    fCnOut = open(outPutPath, "w");

    # 输入前后的提示
    # stringTip = '\n\n/* \n    This text file was create automatic by loadStringFromServer.py \n        create time :'
    # stringTip += time.strftime('%Y-%m-%d(%A) %H:%M:%S',time.localtime(time.time()))
    # stringTip += '\n        create by :'
    # stringTip += getpass.getuser()
    # stringTip += '\n*/\n\n\n'

    print >> fCnOut  # ,stringTip

    sortKeys = fileStrDict.keys()
    sortKeys.sort();
    for key in sortKeys:
        item = fileStrDict[key]
        print >> fCnOut, '"' + key + '" = "' + item.replace("\"", "\\\"") + '";'
    pass
    fCnOut.close()


pass

def generateLocal():
    currentDir = currentFileDir()
    strBundlePath = currentDir + '/zh-Hans.lproj/Localizable.strings'
    strOutPath = currentDir + '/ShowStringDefine.h'
    print(strBundlePath)


    bundleStrDic = paramBundleStrFile(strBundlePath)
    strKeys = bundleStrDic.keys()
    strKeys.sort()
    # 输出字符串
    printToHeaderFile('string', strKeys, strOutPath)
    print(strKeys)
pass


def main(argv):
    
        generateLocal()

pass

if __name__ == '__main__':
    main(sys.argv)
