window.onerror = function(err,fn,ln) {
    window.alert("Error:" + err + " : " + fn + " : " + ln);
}


var items = ["one","two","three","four","five"];

function hidePanel() {
    pgsidebar.hide(function(res){},function(err){
        window.alert("close error : " + err);
    });
}

function showPanel() {
    pgsidebar.show(function(res){
        if(res || res === 0) {
            resultTxt.innerText = items[res];
            hidePanel();
        }
    },
        function(err) {
            window.alert(err);
        },items);
}


document.addEventListener("deviceready",function(){
    
    btnShow.addEventListener("click",function(){
        showPanel();
    });
    
    btnHide.addEventListener("touchend",function(){
        hidePanel();
    });
    
    // fetch data
    // http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=100/json <- different format
    
    var url = "https://itunes.apple.com/search?entity=software&term=cordova&explicit=yes&limit=200";
    var reqListener = function(res) {
        window.alert("Loaded items: " + this.response.results.length);
        items = this.response.results.map(
            function(obj){
                return obj.trackName;
            });
    };
    
    var xhr = new XMLHttpRequest();
    xhr.addEventListener("load", reqListener);

    xhr.open("GET",url);
    xhr.responseType = "json";
    xhr.send(null);

    
});


