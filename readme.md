
#  Linux User and Group Management

This project provides scripts and instructions to manage **users, groups, and permissions** on Linux systems.  
It is designed for **system administrators** who need to maintain secure and organized multi-user environments.

---

##  Features
- Create and delete users
- Create and delete groups
- Add users to groups
- Modify user/group properties
- Manage file/directory ownership and permissions
- Apply **password policies** and **account restrictions**
- Automate user/group management tasks via scripts

---

##  Commands Used

###  User Management
- `useradd` – add a new user  
- `usermod` – modify an existing user  
- `passwd` – set/change user password  
- `id` – display user ID and groups  
- `whoami` – show current logged-in user  
- `deluser` or `userdel` – delete a user  

### 🔹 Group Management
- `groupadd` – add a new group  
- `groupdel` – delete a group  
- `groupmod` – modify a group  
- `gpasswd -a username groupname` – add user to group  
- `gpasswd -d username groupname` – remove user from group  
- `groups username` – show groups a user belongs to  

### 🔹 Permissions & Ownership
- `chown user:group file` – change file ownership  
- `chmod 755 file` – set file permissions  
- `ls -l` – view permissions  
- `umask` – set default permissions  

---

## 📦 Installation

Clone this repository:
```bash
git clone https://github.com/your-username/linux-user-group-management.git
cd linux-user-group-management
