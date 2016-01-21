var exec = require("cordova/exec");


module.exports = {
	show:function(successCallback, errorCallback,items) {
		exec(successCallback, errorCallback, "PGSideBar", "show", [items]);
	},
	hide:function(successCallback, errorCallback){
		exec(successCallback, errorCallback, "PGSideBar", "hide", []);
	}
}