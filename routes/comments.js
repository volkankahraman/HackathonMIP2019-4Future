const express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose');

// let Company = mongoose.model('Company')

let Comment = mongoose.model('Comment', new mongoose.Schema(
    {
        fullname: String,
        star: Number,
        companyId: String,
        content: String
    }
));

/**
 * @swagger
 * /comments/:
 *    get:
 *      tags:
 *       - Yorumlar
 *      description: Firma Yorumlarını döner
 *      responses:
 *        '200':
 *          description: Başarıyla yorumlar dönüldü
 *
 */

router.get('/', (req,res,next)=>{
    Comment.find({}, (err, comments)=>{
        if(err) console.log(err);
        res.json(comments)
    })
})

/**
 * @swagger
 * /comments/{id}:
 *    get:
 *      parameters:
 *       - name: id
 *         description: Yorum id
 *         in: formData
 *      tags:
 *       - Yorumlar
 *      description: Firma Yorumlarını döner
 *      responses:
 *        '200':
 *          description: Başarıyla yorumlar dönüldü
 *
 */

router.get('/:id', (req, res, next) => {
    Comment.findById(req.params.id, (err, comment) => {
        if (err) console.log(err);
        res.json(comment)
    })
})



/**
 * @swagger
 * /comments/add:
 *    post:
 *      tags:
 *       - Yorumlar
 *      parameters:
 *       - name: companyId
 *         description: Kurum id
 *         in: formData
 *       - name: fullname
 *         description: Kullanıcı adı
 *         in: formData
 *       - name: star
 *         description: Yorum yıldız
 *         in: formData
 *       - name: content
 *         description: Yorum içerik
 *         in: formData
 *      description: Firmaya yorum ekler
 *      responses:
 *        '200':
 *          description: Firmaya yorum eklendi
 *        '404':
 *          description: yol bulunamadı
 *        '500':
 *          description: Sunucu hastası
 *
 */
router.post('/add', (req, res) => {
    Comment.create(req.body, (err, user) => {
        if (err) console.log(err);

        res.json(user)
    })
})

/**
 * @swagger
 * /comments/to/Json/:
 *    get:
 *      tags:
 *       - Yorumlar
 *      description: Firma Yorumlarını döner
 *      responses:
 *        '200':
 *          description: Başarıyla yorumlar dönüldü
 *
 */

router.get('/to/Json', (req, res, next) => {
    let data = [];
    Comment.find({}, (err, comments) => {
        if (err) console.log(err);
        comments.forEach(comment=>{
            data.push({
                comment: comment.content,
                sentiment: (comment.star>3)? 'positive':'negative' 
            })
        })
        res.json(data)
    })
})

/**
 * @swagger
 * /comments/company/{companyId}:
 *    get:
 *      parameters:
 *       - name: companyId
 *         description: Yorum id
 *         in: path
 *      tags:
 *       - Yorumlar
 *      description: Firma Yorumlarını döner
 *      responses:
 *        '200':
 *          description: Başarıyla yorumlar dönüldü
 *
 */

router.get('/company/:companyId', (req, res, next) => {
    Comment.find({ companyId:req.params.companyId}, (err, comments) => {
        if (err) console.log(err);
        res.json(comments)
    })
})


    module.exports = router;