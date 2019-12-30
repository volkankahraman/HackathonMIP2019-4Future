const express = require('express'),
    router = express.Router(),
    nodemailer = require('nodemailer'),
    mongoose = require('mongoose'),
    request = require('request');

let Announcement = mongoose.model('Announcement', new mongoose.Schema(
    {
        companyId: String,
        content: String,
        category: String,
    }
));



/**
 * @swagger
 * /announcements/:
 *    get:
 *      tags:
 *       - Duyurular
 *      description: Duyuru Listesi Verir.
 *      responses:
 *        '200':
 *          description: Başarıyla kullanıcı dönüldü
 *
 */
router.get('/', async (req, res) => {
    Announcement.find({})
        .then((data) => {
            let announcementData = [];
            let count = data.length,i =0;
            console.log(count);
            
            data.forEach(announcement =>{
                let editedannouncement = {};
                editedannouncement.imagePath = '';
                editedannouncement.companyName = '';
                editedannouncement.content = announcement.content;
                editedannouncement.category = announcement.category;
                request({
                    url: 'http://localhost:3000/companies/get/' + announcement.companyId,
                    headers: {
                        "content-type": "application/json",
                    },
                    json: true,
                }, function (error, response, body) {
                        i++;
                        editedannouncement.companyName = body.name;
                        editedannouncement.imagePath = body.imagePath;
                        announcementData.push(editedannouncement)
                        
                        if(count == i)
                            res.json(announcementData)

                    });
                })

            
        })
        .catch((err) => {
            console.log(err);
        })
})



/**
 * @swagger
 * /announcements/add:
 *    post:
 *      tags:
 *       - Duyurular
 *      parameters:
 *       - name: companyId
 *         description: Kurum id
 *         in: formData
 *       - name: content
 *         description: Duyuru İçerik
 *         in: formData
 *       - name: category
 *         description: Duyuru Kategori
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
    Announcement.create(req.body, (err, announcement) => {
        if (err) next(err)
        res.json(announcement)


        let transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.GMAIL_MAIL,
                pass: process.env.GMAIL_PASSWORD
            },
            tls: true
        });

        let mailOptions = {
            from: '4Future@gmail.com',
            to: 'alpcanpears@gmail.com',
            subject: 'Bildirim',
            text: req.body.content
        };

        transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });

    });


})

    module.exports = router;