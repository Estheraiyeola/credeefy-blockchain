module 0x4::student{
    use sui::object::{new};
    use std::string::{String};
    use 0x1::certificate::{Certificate, get_a_certificate};

    public struct Student has key, store{
        id: UID,
        name: String,
        certificates: vector<Certificate>
    }

    public fun new_student(name: String, ctx: &mut TxContext): Student {
        Student {
            id: new(ctx),
            name,
            certificates: vector::empty<Certificate>()
        }
    }


    public fun get_student_certificate(student: &Student, id: UID): &Certificate {
        let certificates = get_all_certificates(student);
        get_a_certificate(certificates, id)
    }

    public fun get_all_certificates(student: &Student): &vector<Certificate>{
        &student.certificates
    }




}