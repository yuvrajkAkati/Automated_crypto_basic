import express from "express";
import axios from "axios";
import {ethers} from "ethers"
import dotenv from "dotenv"
dotenv.config()

const app = express()

const BEARER_TOKEN = process.env.TWITTER_BEARER_TOKEN
const ETHEREUM_RPC = process.env.ETHEREUM_RPC
const PRIVATE_KEY : string = process.env.PRIVATE_KEY || ""
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS
const UNISWAP_ROUTER = process.env.UNISWAP_ROUTER

const provider = new ethers.JsonRpcProvider(ETHEREUM_RPC)
const walletOrSigner = new ethers.Wallet(PRIVATE_KEY ,provider)


async function fetchTweets():Promise<string> {
    const query = "Ethereum OR ETH -is:retweet lang:en"
    const api = `https://api.twitter.com/2/tweets/search/recent?query=${query}&max_results=20`;

    try {
        const response = await axios.get(api,{
            headers : {Authorization : `Bearer ${BEARER_TOKEN}`}
        })
        let bullish = 0
        let bearish = 0
        response.data.data.forEach((tweet : {text : string})=> {
            if(tweet.text.includes("bullish") || tweet.text.includes("buy")){
                bullish++
            }
            if(tweet.text.includes("bearish") || tweet.text.includes("sell")){
                bearish++
            }  
        });

        return bullish > bearish ? "BUY" : "SELL"

    } catch (error) {
        console.log("error fetching tweets")
        return "HOLD"
    }

}


async function run():Promise<void>{
    const result = await fetchTweets()
    console.log(`you should ${result}`)
    if(result === "BUY"){
        //wallet opening and swap eth for usdc
        //should have enough usdc

    }else if(result === "SELL"){
        // wallet opening and sell eth for usdc
        //should have enough eth
    }else{
        //do nothing
    }
}

setInterval(run,60000)

app.post('/',(req,res)=>{

})

app.listen(3000)