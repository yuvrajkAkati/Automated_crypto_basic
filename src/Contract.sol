// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

contract Contract {
    address private UNISWAP_V3_ROUTER = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    ISwapRouter private immutable swapRouter;

    constructor(){
        swapRouter = ISwapRouter(UNISWAP_V3_ROUTER);
    }

    function swapTokens(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint amountIn,
        uint amountOutMin,
        address recipient
    ) external returns (uint256 amountOut) {
        IERC20(tokenIn).transferFrom(msg.sender,address(this),amountIn);
        IERC20(tokenIn).approve(UNISWAP_V3_ROUTER,amountIn) 

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
            tokenIn : tokenIn,
            tokenOut : tokenOut,
            fee : fee,
            recipient : recipient,
            deadline : block.timestamp + 300,
            amountIn : amountIn,
            amountOutMinimum : amountOutMin,
            sqrtPriceLimitX96 : 0
        });

        amountOut = swapRouter.exactInputSingle(params);
        return amountOut;
    }
}



// //// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.16;

// import 'openzeppelin/contracts/token/ERC20/ERC20.sol';

// contract CustomToken is ERC20 {
//     constructor(string memory name , string memory symbol) ERC20(name ,symbol){
//         _mint(msg.sender , 10000 * 10 ** 18);
//     }
// }

// contract Uniswap {
//     string[] public tokens = ['CoinA' , 'CoinB' , 'CoinC'];
//     mapping (string => ERC20) public tokenInstanceMap;
//     uint ethValue = 100000000000000;

//     constructor() {
//         for (uint i = 0; i < tokens.length; i++) 
//         {   
//             CustomToken token = new CustomToken(tokens[i],tokens[i]);            
//             tokenInstanceMap[tokens[i]] = token;
//         }
//     }

//     function getBalance(string memory tokenName , address _address) public view returns(uint) {
//         return tokenInstanceMap[tokenName].balanceOf(_address);
//     }

//     function getName(string memory tokenName) public view returns(string memory) {
//         return tokenInstanceMap[tokenName].name();
//     }

//     function getTokenAddress(string memory tokenName) public view returns(address){
//         return address(tokenInstanceMap[tokenName]);
//     }

//     function swapEthToToken(string memory tokenName) public payable returns(uint) {
//         uint inputValue = msg.value;
//         uint outputValue = ( inputValue / ethValue) * 10 ** 18;
//         require(tokenInstanceMap[tokenName].transfer(msg.sender,outputValue));
//         return outputValue;
//     }

//     function swapTokenToEth(string memory tokenName,uint _amount) public payable returns (uint) {
//         uint exactAmount = _amount/ 10 ** 18;
//         uint ethToBeTransferred = exactAmount * ethValue;
//         require(address(this).balance >= ethToBeTransferred , "dex has low eth");
//         payable(msg.sender).transfer(ethToBeTransferred);
//         require(tokenInstanceMap[tokenName].transferFrom(msg.sender,address(this),_amount));
//         return ethToBeTransferred;
//     }

// }