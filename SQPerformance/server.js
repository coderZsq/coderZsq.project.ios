const http = require('http');

http.createServer((req, res) => {

    if (decodeURI(req.url) == "/fetchMockData") {
        console.log(req.url);

        let randomNumber = function (n) {
            var rnd = "";
            for (var i = 0; i < n; i++)
                rnd += Math.floor(Math.random() * 10);
            return rnd;
        }

        let randomString = function(len) {　　
           len = len || 32;　　
            var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';　　
            var maxPos = $chars.length;　　
            var pwd = '';　　
            for (i = 0; i < len; i++) {　　　　
                 pwd += $chars.charAt(Math.floor(Math.random() * maxPos));　　
            }　　
             return pwd;
        }

        let json = [];
        for (let i = 0; i < 10; i++) {
            let arr = [];
            for (let i = 0; i < randomNumber(2); i++) {
                arr.push("aa")//(randomString(randomNumber(1)));
            }
            json.push(arr);
        }
        res.writeHead(200, {
            'Content-Type': 'application/json'
        });

        res.end(JSON.stringify({
            data: json,
            status: 'success'
        }));
    } 

}).listen(8080);
console.log('listen port = 8080');