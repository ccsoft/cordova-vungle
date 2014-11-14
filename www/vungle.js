/// <reference path='vungle.d.ts'/>

var Vungle =function () {
        };
        Vungle.prototype.init = function (vungleid, config, successcb, errorcb) {
            window.cordova.exec(function () {
                if (successcb)
                    successcb();
            }, function (err) {
                if (errorcb)
                    errorcb(err);
            }, "CordovaVungle", "init", [vungleid, config]);
        };

        Vungle.prototype.playAd = function (config, successcb, errorcb) {
            window.cordova.exec(function (completed) {
                if (successcb)
                    successcb(completed);
            }, function (err) {
                if (errorcb)
                    errorcb(err);
            }, "CordovaVungle", "playAd", [config]);
        };

        Vungle.prototype.isVideoAvailable = function (successcb, errorcb) {
            window.cordova.exec(function (s) {
                successcb(s == 1 ? true : false);
            }, function (err) {
                if (errorcb)
                    errorcb(err);
            }, "CordovaVungle", "isVideoAvailable", []);
        };


    console.log('----------------');
    console.log(Vungle);
if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.vungle) {
    window.plugins.vungle = new Vungle();
}

if (typeof module != 'undefined' && module.exports) {
    module.exports = Vungle;
}
