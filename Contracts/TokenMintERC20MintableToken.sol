pragma solidity ^0.5.0;


/**
 * @title TokenMintERC20MintableToken
 * @author TokenMint (visit https://tokenmint.io)
 *
 * @dev Mintable ERC20 token with burning and optional functions implemented.
 * Any address with minter role can mint new tokens.
 * For full specification of ERC-20 standard see:
 * https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
 */
contract TokenMintERC20MintableToken is ERC20Mintable {

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Constructor.
     * @param name name of the token
     * @param symbol symbol of the token, 3-4 chars is recommended
     * @param decimals number of decimal places of one token unit, 18 is widely used
     * @param initialSupply initial supply of tokens in lowest units (depending on decimals)
     * @param tokenOwnerAddress address that gets 100% of token supply
     */
    constructor(string memory name, string memory symbol, uint8 decimals, uint256 initialSupply, address payable feeReceiver, address tokenOwnerAddress) public payable {
      _name = name;
      _symbol = symbol;
      _decimals = decimals;

      // set tokenOwnerAddress as owner of initial supply, more tokens can be minted later
      _mint(tokenOwnerAddress, initialSupply);

      // pay the service fee for contract deployment
      feeReceiver.transfer(msg.value);
    }

    /**
     * @dev transfers minter role from msg.sender to newMinter
     */
    function transferMinterRole(address newMinter) public {
      addMinter(newMinter);
      renounceMinter();
    }

    /**
     * @dev Burns a specific amount of tokens.
     * @param value The amount of lowest token units to be burned.
     */
    function burn(uint256 value) public {
      _burn(msg.sender, value);
    }

    // optional functions from ERC20 stardard

    /**
     * @return the name of the token.
     */
    function name() public view returns (string memory) {
      return _name;
    }

    /**
     * @return the symbol of the token.
     */
    function symbol() public view returns (string memory) {
      return _symbol;
    }

    /**
     * @return the number of decimals of the token.
     */
    function decimals() public view returns (uint8) {
      return _decimals;
    }
}
