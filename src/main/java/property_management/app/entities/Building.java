package property_management.app.entities;

public class Building {

	private String buildingId;
	private Landlord landlord;
	private String address;
	private String city;
	private String state;
	private String zipCode;
	private String numberOfFloors;

	public Building() {
		super();
	}

	public Building(String buildingId, Landlord landlord, String address, String city, String state, String zipCode,
			String numberOfFloors) {
		super();
		this.buildingId = buildingId;
		this.landlord = landlord;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zipCode = zipCode;
		this.numberOfFloors = numberOfFloors;
	}

	public String getBuildingId() {
		return buildingId;
	}

	public void setBuildingId(String buildingId) {
		this.buildingId = buildingId;
	}

	public Landlord getLandlord() {
		return landlord;
	}

	public void setLandlord(Landlord landlord) {
		this.landlord = landlord;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getNumberOfFloors() {
		return numberOfFloors;
	}

	public void setNumberOfFloors(String numberOfFloors) {
		this.numberOfFloors = numberOfFloors;
	}

	@Override
	public String toString() {
		return "Building [buildingId=" + buildingId + ", landlord=" + landlord + ", address=" + address + ", city="
				+ city + ", state=" + state + ", zipCode=" + zipCode + ", numberOfFloors=" + numberOfFloors + "]";
	}

}
