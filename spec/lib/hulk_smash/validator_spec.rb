require_relative '../../../lib/hulk_smash/validator'

describe HulkSmash::Validator do
  subject { described_class.new(siege_result) }

  context 'when using a supported version of siege' do
    let(:siege_result) do
  %(
  ** SIEGE 2.71
  ** Preparing 15 concurrent users for battle.
  The server is now under siege...
  Lifting the server siege...      done.

  Transactions:		       12487 hits
  )
    end

    it 'is valid' do
      subject.should be_valid
    end
  end

  context 'when not using a supported version of siege' do
    let(:siege_result) do
  %(
  ** SIEGE 1.71
  ** Preparing 15 concurrent users for battle.
  The server is now under siege...
  Lifting the server siege...      done.

  Transactions:		       12487 hits
  )
    end

    it 'is invalid' do
      subject.should_not be_valid
    end

    it 'has reasons for why it is invalid' do
      subject.valid?
      subject.reasons_for_failure.should include("Siege version must be 2.x")
    end
  end
end
