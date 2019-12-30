const express= require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    logger = require('morgan')('dev'),
    swaggerUi = require('swagger-ui-express'),
    swaggerJsdoc = require('swagger-jsdoc'),
    indexRouter = require('./routes/index'),
    usersRouter = require('./routes/users'),
    postsRouter = require('./routes/posts'),
    loginRouter = require('./routes/login'),
    surveyRouter = require('./routes/surveys'),
    commentsRouter = require('./routes/comments'),
    productsRouter = require('./routes/products'),
    announcementsRouter = require('./routes/announcements'),
    companiesRouter = require('./routes/companies'),
    mongoose = require('mongoose'),
    options = {
        swaggerDefinition: {
            info: {
                title: 'Hackathon MIP 2019 Docs',
                version: '1.0.0',
                description: 'REST API endpoints for Project of Hackathon MIP 2019',
                servers: ["http://localhost:3000"],
            },
            securityDefinitions: {
                bearerAuth: {
                    type: 'apiKey',
                    name: 'Authorization',
                    scheme: 'bearer',
                    in: 'header',
                },
            },
        },
        apis: ['./routes/*.js'],
    },
    port = 3000;
require('dotenv').config()
mongoose.connect(process.env.DB_STRING, { useNewUrlParser: true });

app.all('*', function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
    res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');

    if (req.method == 'OPTIONS') {
        res.send(200);
    } else {
        next();
    }
});

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:true}))
app.use(logger)
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerJsdoc(options)));
app.use('/public', express.static('public'))

app.use('/', indexRouter);
app.use('/users', usersRouter)
app.use('/companies', companiesRouter)
app.use('/posts', postsRouter)
app.use('/surveys', surveyRouter)
app.use('/login', loginRouter)
app.use('/comments', commentsRouter)
app.use('/products', productsRouter)
app.use('/announcements', announcementsRouter)


// 404 hatasını error handler'a yolla
app.use((req, res, next) => {
    res.status(404).json({
        err: '404 Bulunamadı'
    })
});

// error handler
app.use((err, req, res, next) => {
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};
    res.status(err.status || 500);

    res.json({
        err: err.message
    });
});

app.listen(port, () => {
    console.log(`Listening on port 3000 http://localhost:${port}`);
});