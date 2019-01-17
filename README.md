iOS project is developed via the classic MVC mode, while introducing Functional and Reactive Cocoa programming ideas.

Overall module division

1.Resource module    

    Internationalized design is adopted to make it adaptive to different languages and cell phones 
    of different countries, meanwhile,resource dynamic program is able to get the latest resource 
    allocation from the server, then update and display that in cell phone APPwithout reinstallation 
    of APP. Besides, script is used for access to resource, therefore simplify its steps.   

2.Network module

    The classic and reliable request library AFNetworking is used to realize double seal of it, simplify 
    the invoke steps and enhance its security.Request to use MD5 to perform data integration checking to
    prevent tampering by middleman. POST is used to make request, and parameters are put in BODY with encryption,
    so as to avoid security issue caused by cleartext exposure.

3.Navigation module

    Navigation part is uniformly encapsulated and distributed. 

4.Memory modules

    There is a combination of encrypted database, general database, serialization and key string storage,
    and different storage method could be adopted according to different security level requirement and 
    specific usage scenario. The storage part is deeply encapsulated for easy invocation and debugging.

5.Account module

    This module is used to store users' information and determine the state of the user. The whole project 
    shares this module which is designed as a singleton. 

6.Module view

    In view section, autolayout and  frame  are used based 
