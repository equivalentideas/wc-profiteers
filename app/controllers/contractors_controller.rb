class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all
  end
end
