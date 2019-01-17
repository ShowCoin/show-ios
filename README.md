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

