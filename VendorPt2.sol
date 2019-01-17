pragma solidity 0.4.25;

contract VendorPt2 {
  struct Item {
    string name;
    uint count;
  }

  address storeOwner;
  mapping(string => Item) inventory;

  event Purchase(address sender, string itemName);

  constructor() public {
    storeOwner = msg.sender;
  }

  function purchaseItem(string itemName) public {
      if (inventory[itemName].count > 0) {
        inventory[itemName].count--;
        emit Purchase(msg.sender, itemName);
      }
      else {
        revert("Item not in inventory.");
      }
  }

  function addItem(string itemName, uint itemCount) {
    require(msg.sender == storeOwner);
    inventory[itemName] = Item(itemName, itemCount);
  }

  function getItemCount(string itemName) view public returns (uint count) {
    return inventory[itemName].count;
  }
}
