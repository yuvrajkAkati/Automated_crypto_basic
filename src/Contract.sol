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
    ) external {
        require(IERC20(tokenIn).transferFrom(msg.sender,address(this),amountIn) , "transfer failed");
        require(IERC20(tokenIn).approve(UNISWAP_V3_ROUTER,amountIn) , "approval failed");

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

        swapRouter.exactInputSingle(params);

    }
    function logBalanceOfUser() external view {
        
    }
}
