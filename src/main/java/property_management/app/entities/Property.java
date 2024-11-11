package property_management.app.entities;

import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

public class Property {
	private int propertyId; // Renamed for consistency
	private String title;
	private String description;
	private String location;
	private String type; // Consider clarifying this if necessary
	private Double price; // Changed to BigDecimal for financial precision
	private byte[] propertyImage; // Binary data for image
	private String flatNo;
	private String floor;
	private String address;
	private String city;
	private String state;
	private String zip_code;
	private double latitude;
	private double longitude;
	private MultipartFile image;
	private String status;
	private int type_id;
	private int managerId;

	// Facilities represented as separate boolean fields for better control
	private boolean swimmingPool;
	private boolean gym;
	private boolean parking;
	private boolean garden;
	private boolean airConditioning;
	private boolean elevator;
	private boolean securitySystem;
	private boolean internet;
	private boolean furnished;

	// Default constructor
	public Property() {
	}

	// Parameterized constructor for easy instantiation
	public Property(int propertyId, String title, String description, String location, String type, Double price,
			byte[] propertyImage) {
		this.propertyId = propertyId;
		this.title = title;
		this.description = description;
		this.location = location;
		this.type = type;
		this.price = price;
		this.propertyImage = propertyImage;
	}

	public Property(String title, String description, String location, String type, Double price, byte[] propertyImage,
			boolean swimmingPool, boolean gym, boolean parking, boolean garden, boolean airConditioning,
			boolean elevator, boolean securitySystem, boolean internet, boolean furnished) {
		super();
		this.title = title;
		this.description = description;
		this.location = location;
		this.type = type;
		this.price = price;
		this.propertyImage = propertyImage;
		this.swimmingPool = swimmingPool;
		this.gym = gym;
		this.parking = parking;
		this.garden = garden;
		this.airConditioning = airConditioning;
		this.elevator = elevator;
		this.securitySystem = securitySystem;
		this.internet = internet;
		this.furnished = furnished;
	}

	// Getters and setters

	public int getPropertyId() {
		return propertyId;
	}

	public int getManagerId() {
		return managerId;
	}

	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}

	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public byte[] getpropertyImage() {
		return propertyImage;
	}

	public void setpropertyImage(byte[] propertyImage) {
		this.propertyImage = propertyImage;
	}

	public int getType_id() {
		return type_id;
	}

	public void setType_id(int type_id) {
		this.type_id = type_id;
	}

	public byte[] getPropertyImage() {
		return propertyImage;
	}

	public void setPropertyImage(byte[] propertyImage) {
		this.propertyImage = propertyImage;
	}

	public String getFlatNo() {
		return flatNo;
	}

	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
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

	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public MultipartFile getImage() {
		return image;
	}

	public void setImage(MultipartFile image) {
		this.image = image;
	}

	public boolean isSwimmingPool() {
		return swimmingPool;
	}

	public void setSwimmingPool(boolean swimmingPool) {
		this.swimmingPool = swimmingPool;
	}

	public boolean isGym() {
		return gym;
	}

	public void setGym(boolean gym) {
		this.gym = gym;
	}

	public boolean isParking() {
		return parking;
	}

	public void setParking(boolean parking) {
		this.parking = parking;
	}

	public boolean isGarden() {
		return garden;
	}

	public void setGarden(boolean garden) {
		this.garden = garden;
	}

	public boolean isAirConditioning() {
		return airConditioning;
	}

	public void setAirConditioning(boolean airConditioning) {
		this.airConditioning = airConditioning;
	}

	public boolean isElevator() {
		return elevator;
	}

	public void setElevator(boolean elevator) {
		this.elevator = elevator;
	}

	public boolean isSecuritySystem() {
		return securitySystem;
	}

	public void setSecuritySystem(boolean securitySystem) {
		this.securitySystem = securitySystem;
	}

	public boolean isInternet() {
		return internet;
	}

	public void setInternet(boolean internet) {
		this.internet = internet;
	}

	public boolean isFurnished() {
		return furnished;
	}

	public void setFurnished(boolean furnished) {
		this.furnished = furnished;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImageAsBase64() {
		if (propertyImage != null && propertyImage.length > 0) {
			return Base64.getEncoder().encodeToString(propertyImage);
		}
		return ""; // Return an empty string if there's no image
	}

}
