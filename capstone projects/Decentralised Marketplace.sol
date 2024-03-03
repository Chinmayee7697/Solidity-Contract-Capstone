/*
Problem Statement 1: Decentralized Marketplace

Objective: Develop a Decentralized Marketplace contract where users can list items for sale and others
can purchase them using Ether.

Sellers should list items with a name and price.
Buyers can purchase items by sending Ether equal to the listed price.
Ensure that the Ether sent by buyers is transferred to the seller.
Implement functionality to mark items as sold upon purchase to prevent further sales.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedMarketplace{
    
    struct Product{
        uint256 productId;
         string name;
         uint256 price;
         address seller;
         bool sold;
         string details; 
    }

    address public owner;

    //mapping productId with Product
    mapping(uint256=>Product) public products;

    //total number of products in a list
    uint256 public productCount;

    // Mapping to keep track of authorized sellers
    mapping(address => bool) public authorizedSellers;

    modifier authOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier isAuthorizedSeller() {
        require(authorizedSellers[msg.sender], "Real ID se aao seller bhai");
        _;
    }

    modifier productAvailable(uint256 productId) {
         require(productId < productCount, "Product is Out of Stock");
        _;
    }

    modifier notSold(uint256 productId) {
        require(!products[productId].sold, "Sold out");
        _;
    }

    constructor() {
        owner=msg.sender;
        productCount=0; //initially no. of products set to 0
    }

    // Allowing the owner to authorize sellers
    function authorizeSeller(address _seller) external authOwner {
        authorizedSellers[_seller] = true;
    }

    // Allowing authorized sellers to add products to the list
    function addProduct(string memory _name, uint256 _price, string memory _details)  external isAuthorizedSeller{

        products[productCount] = Product({
            productId: productCount,
            name: _name,
            price: _price,
            seller: msg.sender,
            sold: false,
            details: _details
        });

        productCount++;
    }


    //Buyers can purchase items by sending Ether equal to the listed price.
     function buyProduct(uint256 productId) external payable productAvailable(productId) notSold(productId) {

        Product storage product = products[productId];

        //the ether send by buyer is sufficient or not
        require(msg.value == product.price, "Pure pese de bhai");

        // Ensuring that the Ether sent by buyers is transferred to the seller.
        payable(product.seller).transfer(msg.value);
        product.sold = true;
    }

    // Implement functionality to mark items as sold upon purchase to prevent further sales.
    function isProductSold(uint256 productId) external view returns (bool) {
        return products[productId].sold;
    } 

     // New function to get the product ID by providing the name
    function getProductIdByName(string memory productName) external view returns (uint256) {
        for (uint256 i = 0; i < productCount; i++) {
            if (keccak256(abi.encodePacked(products[i].name)) == keccak256(abi.encodePacked(productName))) {
                return i;
            }
        }
        revert("Product not found");
    }   
}


