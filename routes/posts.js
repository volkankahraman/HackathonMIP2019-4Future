const express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose');
// let Comment = mongoose.model('Comment', new mongoose.Schema(
//     {
//         userId: String,
//         content: String,
//         comments: Array
//     }
// ));
let Post = mongoose.model('Post', new mongoose.Schema(
    {
        fullname: String,
        content: String,
        category: String,
        comments: Array
    }
));


/**
 * @swagger
 * /posts/addComment:
 *    post:
 *      tags:
 *       - Paylaşımlar
 *      parameters:
 *       - name: postid
 *         description: Post İd
 *         in: formData
 *       - name: fullname
 *         description: Yorum yapan ad soyad
 *         in: formData
 *       - name: content
 *         description: Yorum İçerik
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

router.post('/addComment', (req,res,next) => {
    Post.findById(req.body.postid,(err, post)=>{
        post.comments.push(req.body);
        post.save((err, comment)=>{
            if(err) console.log(err);
            res.json(comment)
        });
    })
})

/**
 * @swagger
 * /posts/:
 *    get:
 *      tags:
 *       - Paylaşımlar
 *      description: Karşılama Üye Listesi Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/', (req, res) => {
    Post.find({})
        .then((data) => {
            res.json(data)
        })
        .catch((err) => {
            console.log(err);
        })
})

/**
 * @swagger
 * /posts/comment/{id}:
 *    get:
 *      parameters:
 *       - name: id
 *         description: Post İd
 *         in: path
 *      tags:
 *       - Paylaşımlar
 *      description: İd'ye ait postun yorumlarını döner
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/comment/:id', (req, res) => {
    Post.findById(req.params.id)
        .then((data) => {
            res.json(data.comments)
        })
        .catch((err) => {
            console.log(err);
        })
})




/**
 * @swagger
 * /posts/add:
 *    post:
 *      tags:
 *       - Paylaşımlar
 *      parameters:
 *       - name: fullname
 *         description: Kullanıcı Ad Soyad
 *         in: formData
 *       - name: content
 *         description: Post İçerik
 *         in: formData
 *       - name: category
 *         description: Post Kategori
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

router.post('/add', (req, res, next) => {
    Post.create(req.body,(err, post) => {
        if (err) next(err)
        res.json(post)
    });
})

module.exports = router;