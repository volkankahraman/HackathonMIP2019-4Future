const express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose'),
    jwt = require('jsonwebtoken')

/**
* @swagger
* /login:
*    post:
*      parameters:
*       - name: mail
*         description: Admin 
*         in: formData
*       - name: password
*         description: Şifre
*         in: formData
*      tags:
*       - Login
*      description: Karşılama Üye Listesi Verir.
*      responses:
*        '200':
*          description: Başarıyla kullanıcı dönüldü
*
*/

    router.post('/', (req,res, next)=>{
        if (req.body.mail == process.env.SYSTEM_ADMIN){
            jwt.sign({type: 'systemAdmin'}, process.env.SECRET, (err, token) => {
                res.json({ message:1, token })
            })
        }
        else if (req.body.mail == process.env.Channel_ADMIN){
            jwt.sign({ type: 'channelAdmin' },process.env.SECRET,(err, token)=>{
                res.json({ message: 2,token})
            })
        }else if(req.body.mail == process.env.Company_ADMIN){
            jwt.sign({ type: 'companyAdmin' }, process.env.SECRET, (err, token) => {
                res.json({ message: 3, token })
            })
        }else{
            res.json({ message: 0})
        }
    })

    module.exports = router