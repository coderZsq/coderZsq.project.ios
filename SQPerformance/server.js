const http = require('http');

http.createServer((req, res) => {

    if (decodeURI(req.url) == "/fetchMockData") {
        console.log(req.url);

        let randomNumber = function (n) {
            var randomNumber = "";
            for (var i = 0; i < n; i++)
                randomNumber += Math.floor(Math.random() * 10);
            return randomNumber;
        }

        let randomString = function(len) {　　
           len = len || 32;　　
            var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';　　
            var maxPos = $chars.length;　　
            var randomString = '';　　
            for (i = 0; i < len; i++) {　　　　
                randomString += $chars.charAt(Math.floor(Math.random() * maxPos));　　
            }　　
            return randomString;
        }

        let json = [];
        for (let i = 0; i < 100; i++) {
            let obj = {};
            let texts = [];
            let images = [];
            for (let i = 0; i < randomNumber(4); i++) {
                texts.push(randomString(randomNumber(1)));
            }
            for (let i = 0; i < 16; i++) {
                images.push("https://upload-images.jianshu.io/upload_images/12332870-d145e76f9f3d74d1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240");
            }
            obj.texts = texts;
            obj.images = images;
            json.push(obj);
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