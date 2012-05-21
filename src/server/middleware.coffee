loadUser = (req,res,next)->
    # загрузка данных пользователя
    next()

exports.all = [
    loadUser
]