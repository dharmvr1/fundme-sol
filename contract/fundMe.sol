// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {PriceContverter} from "contract/priceConverter.sol";
contract FundMe{
   using  PriceContverter for uint256;
   uint256 public  minimumUse=5e18; 
   address[] public funders;
   mapping (address=>uint256) public addressToAmountFunded;
   function fund()public payable  {
      // allow users to send money
    //  have a  minimum $ sent

         require(msg.value.getConversionRate() > minimumUse,"did not send enough ETH");
         funders.push(msg.sender);
         addressToAmountFunded[msg.sender]+=msg.value;
   }   

   function withdraw()public {
      for(uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){
         address funder=funders[funderIndex];
         addressToAmountFunded[funder]=0;
      }
      funders=new address[](0);
      // transfer
      // send
      // call
      (bool callSuccess,)=payable(msg.sender).call{value:address(this).balance}("");
      require(callSuccess,"call failed");
   }

    

  
}