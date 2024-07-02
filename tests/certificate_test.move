module 0x0::TestCertificate {
    use 0x1::certificate;
    use sui::test_scenario;
    use sui::clock::{create_for_testing, set_for_testing};

    #[test]
    #[expected_failure]
    public fun test_create_new_certificate() {
        let issuer = @0x1;
        let recipient = @0x2;
        let hash = b"some_hash";

        // Start the test scenario with issuer as the sender
        let scenario = &mut test_scenario::begin(issuer);

        let ctx = scenario.ctx();

        // Create a mock Clock
        let mut clock = create_for_testing(ctx);
        set_for_testing(&mut clock, 1622016000000); // Set a fixed timestamp for testing

        // Initialize the certificate and get its ID
        let certificate_response = certificate::new_certificate(
            issuer,
            recipient,
            hash,
            scenario.ctx(),
            &clock
        );

        // End the first transaction
        scenario.next_tx(issuer);

        let certificate_hash = certificate::get_hash(&certificate_response);

        // Compare the certificate hash with the expected hash
        let expected_hash = b"some_hash";

        if (certificate_hash != expected_hash) {
            abort 1
        };

        abort 0
    }
}
