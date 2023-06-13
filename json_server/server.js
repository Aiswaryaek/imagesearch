const server = require('json-server').create()

const db = require("./db.json")

server.get('/images', (req, res) => {
    const { keyword, category } = req.query
    console.log( keyword, category )
    const result = db.filter((item) => {
        if (category && keyword) {
            return item.keywords.includes(keyword) && item.category == category
        }
        if (keyword) {
            return item.keywords.includes(keyword)
        }
        if (category) {
            return item.category == category
        }
        return true
    })
    res.status(200).jsonp({
        message: "data fetched succesfully",
        data: result,
        status: "success"
    })
})


server.listen(3000, () => {
    console.log('JSON Server is running')
})