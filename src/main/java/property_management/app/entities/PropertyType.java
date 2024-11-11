package property_management.app.entities;

public class PropertyType {

	private int propertTypeId;
	private String typeName;

	public PropertyType() {
		super();
	}

	public PropertyType(int propertTypeId, String typeName) {
		super();
		this.propertTypeId = propertTypeId;
		this.typeName = typeName;
	}

	public int getPropertTypeId() {
		return propertTypeId;
	}

	public void setPropertTypeId(int propertTypeId) {
		this.propertTypeId = propertTypeId;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@Override
	public String toString() {
		return "PropertyType [propertTypeId=" + propertTypeId + ", typeName=" + typeName + "]";
	}

}
