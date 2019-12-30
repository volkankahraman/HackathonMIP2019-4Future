const express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose');


let Company = mongoose.model('Company', new mongoose.Schema(
    {
        name: String,
        sector: String,
        telNo: String,
        mail: String,
        website: String,
        nace: String,
        fax: String,
        adress: String,
        imagePath: String,
        longitude: Number,
        latitude: Number,
    }
));

let Promotion = mongoose.model('Promotion', new mongoose.Schema(
    {
        name: String,
        companyId: String,
        content: String,
        endDate: String,
    }
));

/**
 * @swagger
 * /companies/:
 *    get:
 *      tags:
 *       - Kurumlar
 *      description: Karşılama Üye Listesi Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/', (req, res) => {
    Company.find({})
        .then((data) => {
            res.json(data)
        })
        .catch((err) => {
            console.log(err);
        })
})

/**
 * @swagger
 * /companies/get/{id}:
 *    get:
 *      tags:
 *       - Kurumlar
 *      parameters:
 *       - name: id
 *         description: path
 *         in: path
 *      description: Id'ye göre şirket döner.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/get/:id', (req, res) => {
    Company.findById(req.params.id)
        .then((data) => {
            res.json(data)
        })
        .catch((err) => {
            console.log(err);
        })
})

/**
* @swagger
* /companies/add:
*    post:
*      tags:
*       - Kurumlar
*      parameters:
*       - name: name
*         description: Kurum adı
*         in: formData
*       - name: sector
*         description: Kurum Türü
*         in: formData
*       - name: telNo
*         description: Kurum Tel No
*         in: formData
*       - name: imagePath
*         description: Kurum Resim Yolu
*         in: formData
*       - name: fax
*         description: Kurum Fax
*         in: formData
*       - name: adress
*         description: Kurum Adresi
*         in: formData
*       - name: website
*         description: Kurum Websitesi
*         in: formData
*       - name: nace
*         description: Kurum Nace kodu
*         in: formData
*       - name: longitude
*         description: Kurum boylamı
*         in: formData
*       - name: latitude
*         description: Kurum enlemi
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
    Company.create(req.body, (err, user) => {
        if (err) console.log(err);

        res.json(user)
    })
})
/**
* @swagger
* /companies/{companyId}/addPromotion:
*    post:
*      tags:
*       - Kampanyalar
*      parameters:
*       - name: name
*         description: Kampanya adı
*         in: formData
*       - name: companyId
*         description: Kurum ID
*         in: path
*       - name: content
*         description: Kampanya İçerik
*         in: formData
*       - name: endDate
*         description: Kampanya bitiş tarihi
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

router.post('/:companyId/addPromotion',(req,res,next)=>{
    req.body.companyId = req.params.companyId;
    Promotion.create(req.body, (err,promotion)=>{
        // if(err) next(err)
        if(err) console.log(err);
        
        res.json(promotion)
    })
})

/**
 * @swagger
 * /companies/{companyId}/Promotions:
 *    get:
 *      parameters:
 *       - name: companyId
 *         description: Kurum ID
 *         in: path
 *      tags:
 *       - Kampanyalar
 *      description: Karşılama Üye Listesi Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */

router.get('/:companyId/Promotions', (req, res, next) => {
    Promotion.find({ companyId: req.params.companyId}, (err, promotions) => {
        if (err) console.log(err);
        res.json(promotions)
    })
})

/**
 * @swagger
 * /companies/:id/analyseComment:
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
// router.post(':id//analyseComment', (req, res) => {
//     request.post({
//         headers: { 'content-type': 'application/x-www-form-urlencoded' },
//         url: 'http://localhost:5000/predict',
//         body: "yorum=" + req.body.comment,
//         json: true
//     }, function (error, response, body) {
//         res.json(body);
//     });
// })

module.exports = router;

