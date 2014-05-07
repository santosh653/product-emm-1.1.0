var notification = (function () {
	
    var module = function (db,router) {
		var notificationModule = require('modules/notification.js').notification;
		var notification = new notificationModule(db);
		router.get('notifications/devices/{deviceid}', function(ctx){
		    var result = notification.getNotifications(ctx);
		    if(result!= null && result != undefined && result[0] != null && result[0] != undefined){
		        print(result);
		        response.status = 200;
		    }else{
		        response.status = 404;
		    }
		});

		router.post('notifications/ios', function(ctx){
		    var result = notification.addIosNotification(ctx);
		});

		router.post('notifications', function(ctx){
		    var result = notification.addNotification(ctx);
		});

		router.get('refresh/devices/{deviceid}/{operation}', function(ctx){
		    var result = notification.getLastRecord(ctx);
		    if(result!= null && result != undefined){
                log.debug("Refresh:- occured");
		        print(result);
		        response.status = 200;
		    }else{
		        response.status = 404;
		    }
		});

        /*
         Device contacts this api to get and update the pending operations
         */
        router.post('notifications/pendingOperations', function(ctx) {

            var operations = notification.getAndroidOperations(ctx);
            if(operations != null) {
                //Pending Operations - Send Payload
                response.status = 200;
                response.content = operations;
            } else {
                response.status = 401;
                response.content = "SUCCESS";
            }
        });
		
    };
    // prototype
    module.prototype = {
        constructor: module
    };
    // return module
    return module;
})();