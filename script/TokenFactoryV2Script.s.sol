// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

import {TokenFactoryV2} from "../src/TokenFactoryV2.sol";

contract TokenFactoryV2Script is Script {
    address public proxy = 0xF420C0c9DC55505EED6cA62d2222992859Dc7227;
    address public erc20Token = 0x7b1Ac9ebB14B7Ac4C8B21824629c6d31F555EE84;

    function setUp() public {}


    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        console.log("Deploying contracts with the account:", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);

        Upgrades.upgradeProxy(
            address(proxy),
            "TokenFactoryV2.sol:TokenFactoryV2",
            "",
            deployerAddress
        );
        (bool successful, ) = address(proxy).call(
            abi.encodeWithSelector(
                TokenFactoryV2.setTokenAddress.selector,
                address(erc20Token)
            )
        );
        console.log("setTokenAddress success:", successful);

        // console.log("TokenFactoryV1 deployed to:", address(factoryv2));

        vm.stopBroadcast();
    }
}

