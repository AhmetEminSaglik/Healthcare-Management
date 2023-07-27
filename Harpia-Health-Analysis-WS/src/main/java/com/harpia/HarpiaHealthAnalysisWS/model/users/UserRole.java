/*
package com.harpia.HarpiaHealthAnalysisWS.model.users;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user_roles", uniqueConstraints = @UniqueConstraint(columnNames = "role"))
public class UserRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    int id;
    @Column()
    String role;

//    @JsonBackReference
//    @OneToOne(mappedBy = "userRole")
//    private User user;
}
*/
