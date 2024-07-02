module 0x7::mr_sk{
    
    #[test]
    public fun print(){
        let number : u64 = 5;
        std::debug::print(&number)
    }
}