(() => {
    const pageLang = $('html').attr('lang').toLowerCase()
    const userLang = navigator.language.toLowerCase()
    if (pageLang.startsWith('en') && userLang.startsWith('zh')) {
        location = '/zh' + location.pathname
    } else if (pageLang.startsWith('zh') && !userLang.startsWith('zh')) {
        location = location.pathname.slice(3)
    }
})()

