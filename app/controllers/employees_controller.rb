class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.search(params[:search])
    @employees = @employees.page(1).per(50)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    if employee_params['profile_image'].include?('.png') || employee_params['profile_image'].include?('.jpg')
      @employee = Employee.new(employee_params)
      respond_to do |format|
        begin
          if @employee.save
            format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
            format.json { render :show, status: :created, location: @employee }
          else
            format.html { render :new, notice: @employee.errors}
            format.json { render json: @employee.errors, status: :unprocessable_entity }
          end
        rescue Exception => e
          format.html { render :new, notice: e.inspect}
          format.json { render json: e.inspect, status: :unprocessable_entity }
        end        
      end
    else
      format.html { render :new }
      format.json { render json: 'Image format not supported', status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :address, :email, :phone, :dob, :profile_image)
    end
end
