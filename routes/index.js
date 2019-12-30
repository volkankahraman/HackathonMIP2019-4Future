const express = require('express'),
    router = express.Router(),
    request = require('request'),
    jwt = require('jsonwebtoken'),
    mongoose = require('mongoose');

/**
 * @swagger
 * /:
 *    get:
 *      tags:
 *       - Anasayfa
 *      description: Karşılama mesajı verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/', (req, res)=> {
    res.json({
        message: 'Hackathon MIP 2019! - 4 FUTURE'
    })
})

/**
 * @swagger
 * /createToken:
 *    post:
 *      tags:
 *       - Üçüncü Parti
 *      description: Karşılama mesajı verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.post('/createToken', (req, res) => {
    jwt.sign(req.body,process.env.SECRET,(err,token)=>{
        res.json({
            token
        })
    })
})

/**
 * @swagger
 * /analyseComment:
 *    post:
 *      tags:
 *       - Veri Analizi
 *      parameters:
 *       - name: comment
 *         description: Yorum
 *         in: formData
 *      description: Karşılama mesajı verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.post('/analyseComment', (req, res) => {
        request.post({
            headers: { 'content-type': 'application/x-www-form-urlencoded' },
            url: 'http://localhost:5000/predict',
            body: "yorum="+req.body.comment,
            json:true
        }, function (error, response, body) {
            res.json(body);
        });
})






module.exports = router;


