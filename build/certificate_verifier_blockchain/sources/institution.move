module 0x3::institution{
    use sui::object::{new};
    use sui::clock::Clock;
    use std::string::{String};
    use 0x4::student::{Student};
    use sui::transfer::{public_transfer};
    use 0x1::certificate::{Certificate, new_certificate};  // Reference the Certificate struct


    public struct Institution has key, store{
        id: UID,
        name: String,
        students: vector<Student>,
        verified: bool
    }

    public fun new_institution(name: String, ctx: &mut TxContext): Institution {
        Institution {
            id: new(ctx),
            name: name,
            students: vector::empty<Student>(),
            verified: false
        }
    }

    public fun issue_certificate(_institution: &Institution, issuer: address, recipient: address, hash: vector<u8>, ctx: &mut TxContext, clock: &Clock): Certificate {

        let new_certificate= new_certificate(issuer, recipient, hash, ctx, clock);
        new_certificate
    }

    public fun transfer_certificate_to_owner(certificate: Certificate, recipient: address){
        public_transfer(certificate, recipient);

    }


     public fun get_all_students(institution: &Institution): &vector<Student> {
        &institution.students
    }

    public fun add_students_to_institution(institution: &mut Institution, student: Student){
        vector::push_back(&mut institution.students, student)
    }
}