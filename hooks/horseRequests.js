
const options = {
    method: 'GET',
    url: 'https://horse-racing.p.rapidapi.com/horse-stats/207660',
    headers: {
        'X-RapidAPI-Key': `${env.X_RapidAPI_Key}`,
        'X-RapidAPI-Host': 'horse-racing.p.rapidapi.com'
    }
};

export async function getHorseData() {
    try {
        const response = await axios.request(options);
        //console.log(response.data);
        return response.data;
    } catch (error) {
        console.error(error);
    }
}

getHorseData()

