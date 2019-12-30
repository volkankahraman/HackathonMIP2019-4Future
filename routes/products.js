const express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose');

let Product = mongoose.model('Product', new mongoose.Schema(
    {
        name: String,
        companyId: String,
        category: String,
        brand: String,
        model: String,
        price: Number,
        stock: Number
    }
));
let Sales = mongoose.model('Sales', new mongoose.Schema(
    {
        // produc: Product,
        amount: Number,
        userfullname:String
    }
));

/**
 * @swagger
 * /products/{companyId}:
 *    get:
 *      parameters:
 *       - name: companyId
 *         description: Kurum id
 *         in: path

 *      tags:
 *       - Ürünler
 *      description: Ürünleri Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/:companyId', (req, res) => {
    Product.find({companyId: req.params.companyId})
        .then((data) => {
            res.json(data)
        })
        .catch((err) => {
            console.log(err);
        })
})
/**
 * @swagger
 * /products/{companyId}/add:
 *    post:
 *      tags:
 *       - Ürünler
 *      parameters:
 *       - name: companyId
 *         description: Kurum id
 *         in: path
 *       - name: name
 *         description: Ürün adı
 *         in: formData
 *       - name: category
 *         description: Ürün kategori
 *         in: formData
 *       - name: brand
 *         description: Ürün Marka
 *         in: formData
 *       - name: model
 *         description: Ürün Model
 *         in: formData
 *       - name: price
 *         description: Ürün fiyat
 *         in: formData
 *       - name: stock
 *         description: Ürün adet
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
router.post('/:companyId/add', (req, res) => {
    req.body.companyId = req.params.companyId
    Product.create(req.body, (err, product) => {
        if (err) console.log(err);

        res.json(product)
    })
})

/**
 * @swagger
 * /products/{productId}/sell:
 *    post:
 *      parameters:
 *       - name: productId
 *         description: Ürün id
 *         in: path
 *      tags:
 *       - Ürünler
 *      description: Ürünleri Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.post('/:productId/sell', (req, res) => {
    Product.findById(req.params.productId)
        .then((data) => {
            data.stock--;
            data.save()
            res.json(data)
        })
        .catch((err) => {
            console.log(err);
        })
})






module.exports = router;