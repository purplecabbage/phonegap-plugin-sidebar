
var urlutil = require('cordova/urlutil');
var bodyOverflowStyle;
var sideBar;

function hideSideBar() {
    document.body.removeChild(sideBar);
    sideBar = null;
    document.body.style.transform = "";
}

module.exports = {
    show:function(cbSuccess,cbError,args) {
        console.log("show called");

        if (sideBar) {
            setTimeout(function () {
                cbError("sideBar is already shown");
            });
            return;
        }

        var items = args[0];
        var sideBarStyle = document.createElement('link');
        sideBarStyle.rel = "stylesheet";
        sideBarStyle.type = "text/css";
        sideBarStyle.href = urlutil.makeAbsolute("/www/sideBarStyle.css");
        //sideBarStyle.onload = function () { };
        document.head.appendChild(sideBarStyle);

        sideBar = document.createElement("div");
        sideBar.className = "sideBar";
        sideBar.style.height = window.innerHeight + "px";

        document.body.style.transform = "translate(300px,0)";

        //// Save body overflow style to be able to reset it back later
        //bodyOverflowStyle = document.body.style.msOverflowStyle;
        //// Hide scrollbars for the whole body while inappbrowser's window is open
        //document.body.style.msOverflowStyle = "none";

        var itemsList = document.createElement("ul");
        for(var n = 0; n < items.length; n++) {
            var li = document.createElement("li");
            li.innerText = items[n];
            li.attributes.dataIndex = n;
            itemsList.appendChild(li);
        }

        itemsList.addEventListener("click", function (evt) {
            console.log("evt " + evt.srcElement.attributes.dataIndex);
            var index = evt.srcElement.attributes.dataIndex;
            setTimeout(function () {
                cbSuccess(index);
            });

        });

        sideBar.appendChild(itemsList);
        document.body.appendChild(sideBar);        
    },
    hide:function(cbSuccess,cbError) {
        console.log("hide called");
        if (sideBar) {
            hideSideBar();
            cbSuccess();
        }
        else {
            cbError();
        }
        
    }
};


require("cordova/exec/proxy").add("PGSideBar",module.exports);

