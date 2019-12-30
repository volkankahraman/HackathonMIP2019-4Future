const express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose');
let User = mongoose.model('User', new mongoose.Schema(
    {
        username: String,
        fullname: String,
        age: Number,
        password: String,
        gender: String,
        type: String,
        moneyPoint:Number
    }
));

/**
 * @swagger
 * /users/:
 *    get:
 *      tags:
 *       - Kullanıcılar
 *      description: Karşılama Üye Listesi Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/', (req, res) => {
    User.find({})
        .then((data) => {
            res.json(data)
        })
        .catch((err) => {
            console.log(err);
        })
})

/**
 * @swagger
 * /users/add:
 *    post:
 *      tags:
 *       - Kullanıcılar
 *      parameters:
 *       - name: username
 *         description: Kullanıcı adı
 *         in: formData
 *       - name: fullname
 *         description: Kullanıcı Ad Soyad
 *         in: formData
 *       - name: type
 *         description: Kullanıcı Türü
 *         in: formData
 *       - name: age
 *         description: Kullanıcı Yaşı
 *         in: formData
 *       - name: password
 *         description: Kullanıcı Şifre
 *         in: formData
 *       - name: gender
 *         description: Kullanıcı Cinsiyet
 *         in: formData
 * 
 *      description: İstenilen idye ait bir dil döner
 *      responses:
 *        '200':
 *          description: İstenilen kullanıcı eklendi
 *        '404':
 *          description: yol bulunamadı
 *        '500':
 *          description: Sunucu hastası
 *
 */

router.post('/add', (req, res) => {
    req.body.moneyPoint = 100;
    User.create(req.body, (err, user) => {
        if (err) console.log(err);

        res.json(user)
    })
})


    module.exports = router;