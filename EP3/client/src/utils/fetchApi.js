export default async (method, url, body) => {
    const session = sessionStorage.getItem('auth')
    if (session && method === 'POST') {
        const auth = JSON.parse(sessionStorage.getItem('auth'))
        console.log(auth)
        body = {...body, ...{
            auth: {
                login: auth.username,
                password: auth.senha
            }
        }}
    }
    console.log(body)
    const response = await fetch(url, {
        method: method,
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
    })
    try {
        const content = await response.json()
        return {
            ...content,
            ok: response.ok,
            redirected: response.redirected,
            status: response.status,
            statusText: response.statusText
        }
    }
    catch (err) { return response }
}