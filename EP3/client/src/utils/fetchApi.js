export default async (method, url, body) => {
    const response = await fetch(url, {
        method: method,
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
    })
    console.log(response)
    try {
        const content = await response.json()
        console.log(content)
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