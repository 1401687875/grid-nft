
module grid_nft::grid_nft {
    use sui::object::{UID,Self};
    use sui::tx_context::{sender,TxContext};
    use std::string;
    use std::string::{String,utf8};
    use sui::package;
    use sui::display;
    use sui::transfer;
    struct Grid has key,store{
        id: UID,
        name: String,
        img_url: String,
        thumbnail_url: String,
        creator: String,
    }
    
    struct GRID_NFT has drop{}
    fun init(otw: GRID_NFT,ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"image_url"),
            utf8(b"thumbnail_url"),
            utf8(b"creator"),
        ];
        let values = vector[
            utf8(b"{name}"),
            utf8(b"{img_url}"),
            utf8(b"{img_url}"),
            utf8(b"北飞的企鹅"),
        ];
        let publisher = package::claim(otw,ctx);
        let display = display::new_with_fields<Grid>(&publisher,keys,values,ctx);
        display::update_version(&mut display);
        transfer::public_transfer(publisher,sender(ctx));
        transfer::public_transfer(display,sender(ctx));

        let nft = Grid{
            id: object::new(ctx),
            name: string::utf8(b"grid"),
            img_url: string::utf8(b"https://raw.githubusercontent.com/1401687875/move_test/master/grid.jpg"),
            thumbnail_url: string::utf8(b"https://raw.githubusercontent.com/1401687875/move_test/master/grid.jpg"),
            creator: string::utf8(b"北飞的企鹅"),
        };
        transfer::public_transfer(nft,sender(ctx));
    }

    public fun mint(name: String,img_url: String,thumbnail_url: String,creator: String,ctx: &mut TxContext){
        let id = object::new(ctx);
        let grid = Grid{
            id: id,
            name: name,
            img_url: img_url,
            thumbnail_url: thumbnail_url,
            creator: creator,
        };
        transfer::public_transfer(grid,sender(ctx));
    }
    
}