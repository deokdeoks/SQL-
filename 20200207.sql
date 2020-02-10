-- °úÁ¦ 
--DROP TABLE cou_postion;

CREATE TABLE cou_postion( 
    g_cd VARCHAR2(20) NOT NULL, 
    g_nm VARCHAR2(50) NOT NULL,
    ord NUMBER,
     CONSTRAINT pk_cou_postion PRIMARY KEY (g_cd)
);

CREATE TABLE cou_dept( 
    d_cd VARCHAR2(20) NOT NULL, 
    d_nm VARCHAR2(50) NOT NULL,
    p_d_cd VARCHAR2(20),
     CONSTRAINT pk_cou_dept PRIMARY KEY (d_cd),
     CONSTRAINT fk_cou_dept FOREIGN KEY (p_d_cd) REFERENCES cou_dept(d_cd)
  );
  
CREATE TABLE cou_job( 
    j_cd VARCHAR2(20) NOT NULL, 
    j_nm VARCHAR2(50) NOT NULL,
    ord NUMBER , 
    CONSTRAINT pk_cou_job PRIMARY KEY (j_cd)
    );


CREATE TABLE cou_tb_cs_cd( 
    cs_cd VARCHAR2(20) NOT NULL, 
    cs_nm VARCHAR2(50) NOT NULL,
    p_cs_cd VARCHAR(20),
    CONSTRAINT pk_cou_tb_cs_cd PRIMARY KEY (cs_cd),
      CONSTRAINT fk_cou_tb_cs_cd FOREIGN KEY (p_cs_cd) REFERENCES cou_tb_cs_cd(cs_cd)
    );
    
    
CREATE TABLE cou_counsel( 
    cs_id VARCHAR2(20) NOT NULL, 
    cs_reg_dt DATE NOT NULL,
    cs_cont VARCHAR2(4000) NOT NULL,
    e_no NUMBER NOT NULL,
    cs_cd1  VARCHAR2(20) NOT NULL,
    cs_cd2  VARCHAR2(20),
    cs_cd3  VARCHAR2(20),
    CONSTRAINT pk_cou_id PRIMARY KEY (cs_id),
    CONSTRAINT fk_cou_no FOREIGN KEY (e_no) REFERENCES cou_c (e_no),
     CONSTRAINT fk_cou_cd1  FOREIGN KEY (cs_cd1) REFERENCES cou_counsel (cs_cd),
     CONSTRAINT fk_cou_cd2  FOREIGN KEY (cs_cd2) REFERENCES cou_counsel (cs_cd),
     CONSTRAINT fk_cou_cd3  FOREIGN KEY (cs_cd3) REFERENCES cou_counsel (cs_cd)
    );
    
