require "rails_helper"

RSpec.describe Account do
  describe "#authenticate" do
    context "correct password" do
      it "returns the Account instance" do
        act = described_class.create(
          email: "alice@example.com",
          password: "correct-horse-battery-staple"
        )
        expect(act.authenticate("correct-horse-battery-staple")).to eq(act)
      end
    end

    context "incorrect password" do
      it "returns false" do
        act = described_class.create(
          email: "alice@example.com",
          password: "correct-horse-battery-staple"
        )
        expect(act.authenticate('incorrect-password')).to eq(false)
      end
    end
  end

  describe "#save" do
    it "persists record" do
      act = described_class.new(
        email: "alice@example.com",
        password: "correct-horse-battery-staple"
      )
      expect(act.save).to eq(true)
      expect(act).to be_persisted
      expect { act.reload }.not_to raise_error
    end

    it "hashes the password, using a salt" do
      act = described_class.create!(
        email: "alice@example.com",
        password: "correct-horse-battery-staple"
      )
      split_hash = lambda do |h|
        _, v, c, mash = h.split('$')
        return v, c.to_i, h[0, 29].to_str, mash[-31, 31].to_str
      end
      bcrypt_version, cost, salt, checksum = split_hash.call(act.password_digest)
      expect(bcrypt_version).to eq("2a")
      expect(cost).to eq(4)
      expect(salt).to be_present
      expect(checksum).to be_present

      # Just for fun, here's how BCrypt works.
      pw = BCrypt::Password.new(act.password_digest)
      expect(pw.version).to eq(bcrypt_version)
      expect(pw.cost).to eq(cost)
      expect(pw.salt).to eq(salt)
      expect(pw.checksum).to eq(checksum)
      expect(pw == "correct-horse-battery-staple").to eq(true)
    end
  end
end
