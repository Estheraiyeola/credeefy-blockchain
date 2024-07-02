module 0x1::certificate{
    use sui::object::{new};
    use sui::clock::{Clock};


    public struct Certificate has key, store{
        id: UID,
        issuer: address,
        recipient: address,
        hash: vector<u8>,
        issued_at: u64,
        verified: bool,
    }


    /// Clock needs to be passed as an immutable reference.
    public fun current_time(clock: &Clock): u64 {
        let time = clock.timestamp_ms();
        (time)
        
    }

    // Function to create a new Certificate object (without public key)
    public fun new_certificate(issuer: address, recipient: address, hash: vector<u8>, ctx: &mut TxContext, clock: &Clock): Certificate {
        Certificate {
            id: new(ctx),
            issuer: issuer,
            recipient: recipient,
            hash: hash,
            issued_at: current_time(clock),
            verified: false
        }
    }


    public fun get_id(certificate: &Certificate): &UID{
        &certificate.id
    }

    public fun get_hash(certificate: &Certificate): &vector<u8>{
        &certificate.hash
    }

    public fun get_a_certificate(certificates: &vector<Certificate>, id: UID): &Certificate {
        let mut i = 0;
        let len = vector::length(certificates);
        while (i < len) {
            if (&certificates[i].id == id) {
                &certificates[i];
            };
            i = i + 1;
        };
        abort 0
    }


}