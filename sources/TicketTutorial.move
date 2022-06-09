module TicketTutorial::Tickets {
    use Std::Signer;

    struct ConcertTicket has key {
		seat: vector<u8>,
		ticket_code: vector<u8>,
	}

    // No need to check for recipient's signature as function can't be executed without recipient signature
    public fun create_ticket(recipient: &signer, seat: vector<u8>, ticket_code: vector<u8>)  {
        // Moves ConcertTicket resource into recipient's account
        move_to<ConcertTicket>(recipient, ConcertTicket {seat, ticket_code})
    }

	#[test(recipient = @0x1)]
    public(script) fun sender_can_create_ticket(recipient: signer) {
		create_ticket(&recipient, b"A24", b"AB43C7F");
		let recipient_addr = Signer::address_of(&recipient);
		assert!(exists<ConcertTicket>(recipient_addr), 1);
    }
}