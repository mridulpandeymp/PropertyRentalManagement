package property_management.app.entities;

public class Role {

	private int roleId;
	private String roleName;

	public Role() {
		super();
	}

	public Role(int roleId) {
		super();
		this.roleId = roleId;
	}

	public Role(String roleName) {
		super();
		this.roleName = roleName;
	}

	public Role(int roleId, String roleName) {
		super();
		this.roleId = roleId;
		this.roleName = roleName;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Override
	public String toString() {
		return "Role [roleId=" + roleId + ", roleName=" + roleName + "]";
	}

}
