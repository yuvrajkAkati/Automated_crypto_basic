// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "src/Contract.sol";

contract TestContract is Test {
    Contract c;
    address tokenIn;
    address tokenOut;
    address user;
    address myAddress = 0xA4e99114eF4c26Ea93C6fB4678a4172941951706; //for tests
    address private constant UNISWAP_V3_ROUTER = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

    function setUp() public {
        c = new Contract();
        tokenIn = 0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6; //weth
        tokenOut = 	0xCe289Bb9FB0A9591317981223cbE33D5dc42268e; //
        deal(address(tokenOut), address(this), 10 * 1e18);
        deal(address(tokenIn) , address(this) , 10 * 1e18);
    }

    function testSwap() public {
        // uint balance = IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6).balanceOf(myAddress); //will not work because sepoliaETH is the native token
        c.swapTokens(tokenIn,tokenOut,300,10000000000000000,0,myAddress);
        uint balance = IERC20(0xCe289Bb9FB0A9591317981223cbE33D5dc42268e).balanceOf(myAddress);
        assert(balance > 0);
    }


// 73326559626325336
}