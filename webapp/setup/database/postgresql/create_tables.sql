CREATE TABLE CMS_USERS ( 
	USER_ID VARCHAR(36) NOT NULL,
	USER_NAME VARCHAR(128) NOT NULL,
	USER_PASSWORD VARCHAR(64) NOT NULL,
	USER_FIRSTNAME VARCHAR(128) NOT NULL,
	USER_LASTNAME VARCHAR(128) NOT NULL,
	USER_EMAIL VARCHAR(128) NOT NULL,
	USER_LASTLOGIN BIGINT NOT NULL,
	USER_FLAGS INT NOT NULL,
	USER_OU VARCHAR(128) NOT NULL,
	USER_DATECREATED BIGINT NOT NULL,
	CONSTRAINT PK_USERS PRIMARY KEY(USER_ID),
	CONSTRAINT UK_USERS UNIQUE(USER_NAME, USER_OU)
);

CREATE INDEX CMS_USERS_01_IDX
	ON CMS_USERS (USER_NAME)
	;
	
CREATE INDEX CMS_USERS_02_IDX
	ON CMS_USERS (USER_OU)
	;
	
CREATE TABLE CMS_USERDATA (
    USER_ID VARCHAR(36) NOT NULL,
    DATA_KEY VARCHAR(255) NOT NULL,
    DATA_VALUE BYTEA,
    DATA_TYPE VARCHAR(128) NOT NULL,
    CONSTRAINT PK_USERDATA PRIMARY KEY(USER_ID, DATA_KEY)
);

CREATE INDEX CMS_USERDATA_01_IDX
	ON CMS_USERDATA (USER_ID)
	;
	
CREATE INDEX CMS_USERDATA_02_IDX
	ON CMS_USERDATA (DATA_KEY)
	;
	
CREATE TABLE CMS_HISTORY_PRINCIPALS (
    PRINCIPAL_ID VARCHAR(36) NOT NULL,
    PRINCIPAL_NAME VARCHAR(128) NOT NULL,
	PRINCIPAL_DESCRIPTION VARCHAR(255) NOT NULL,
	PRINCIPAL_OU VARCHAR(128),
	PRINCIPAL_EMAIL VARCHAR(128) NOT NULL,
	PRINCIPAL_TYPE VARCHAR(5) NOT NULL,
	PRINCIPAL_USERDELETED VARCHAR(36) NOT NULL,
	PRINCIPAL_DATEDELETED BIGINT NOT NULL,
	CONSTRAINT PK_HIST_PRINCIPALS PRIMARY KEY(PRINCIPAL_ID)
);

CREATE TABLE CMS_GROUPS (
	GROUP_ID VARCHAR(36) NOT NULL,
	PARENT_GROUP_ID VARCHAR(36) NOT NULL,
	GROUP_NAME VARCHAR(128) NOT NULL,
	GROUP_DESCRIPTION VARCHAR(255) NOT NULL,
	GROUP_FLAGS INT NOT NULL,
	GROUP_OU VARCHAR(128) NOT NULL,
	CONSTRAINT PK_GROUPS PRIMARY KEY(GROUP_ID),
	CONSTRAINT UK_GROUPS UNIQUE(GROUP_NAME, GROUP_OU)
);

CREATE INDEX CMS_GROUPS_01_IDX 
	ON CMS_GROUPS (PARENT_GROUP_ID)
	;

CREATE INDEX CMS_GROUPS_02_IDX
	ON CMS_GROUPS (GROUP_NAME)
	;
	
CREATE INDEX CMS_GROUPS_03_IDX
	ON CMS_GROUPS (GROUP_OU)
	;
	
CREATE TABLE CMS_GROUPUSERS (
	GROUP_ID VARCHAR(36) NOT NULL,
	USER_ID VARCHAR(36) NOT NULL,
	GROUPUSER_FLAGS INT NOT NULL,
	CONSTRAINT PK_GROUPUSERS PRIMARY KEY(GROUP_ID, USER_ID)
);

CREATE INDEX CMS_GROUPUSERS_01_IDX 
	ON CMS_GROUPUSERS (GROUP_ID)
	;

CREATE INDEX CMS_GROUPUSERS_02_IDX 
	ON CMS_GROUPUSERS (USER_ID)
	;

CREATE TABLE CMS_PROJECTS ( 
	PROJECT_ID VARCHAR(36) NOT NULL,
	PROJECT_NAME VARCHAR(200) NOT NULL,
	PROJECT_DESCRIPTION VARCHAR(255) NOT NULL,
	PROJECT_FLAGS INT NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID VARCHAR(36) NOT NULL,
	GROUP_ID VARCHAR(36) NOT NULL,
	MANAGERGROUP_ID VARCHAR(36) NOT NULL,
	DATE_CREATED BIGINT NOT NULL,
	PROJECT_OU VARCHAR(128) NOT NULL,
	CONSTRAINT PK_PROJECTS PRIMARY KEY(PROJECT_ID),
	CONSTRAINT UK_PROJECTS UNIQUE(PROJECT_OU,PROJECT_NAME,DATE_CREATED)
);

CREATE INDEX CMS_PROJECTS_01_IDX
	ON CMS_PROJECTS (PROJECT_FLAGS)
	;
	
CREATE INDEX CMS_PROJECTS_02_IDX
	ON CMS_PROJECTS (GROUP_ID)
	;
	
CREATE INDEX CMS_PROJECTS_03_IDX
	ON CMS_PROJECTS (MANAGERGROUP_ID)
	;
	
CREATE INDEX CMS_PROJECTS_04_IDX
	ON CMS_PROJECTS (USER_ID)
	;
	
CREATE INDEX CMS_PROJECTS_05_IDX
	ON CMS_PROJECTS (PROJECT_NAME)
	;
	
CREATE INDEX CMS_PROJECTS_06_IDX
	ON CMS_PROJECTS (PROJECT_OU)
	;
	
CREATE INDEX CMS_PROJECTS_07_IDX
	ON CMS_PROJECTS (PROJECT_OU,PROJECT_NAME)
	;
	
CREATE TABLE CMS_HISTORY_PROJECTS (
	PROJECT_ID VARCHAR(36) NOT NULL,
	PROJECT_NAME VARCHAR(255) NOT NULL,
	PROJECT_DESCRIPTION VARCHAR(255) NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID VARCHAR(36) NOT NULL,
	GROUP_ID VARCHAR(36) NOT NULL,
	MANAGERGROUP_ID VARCHAR(36) NOT NULL,
	DATE_CREATED BIGINT NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	PROJECT_PUBLISHDATE BIGINT NOT NULL,
	PROJECT_PUBLISHED_BY VARCHAR(36) NOT NULL,
	PROJECT_OU VARCHAR(128) NOT NULL,
	CONSTRAINT PK_HISTORY_PROJECTS PRIMARY KEY(PUBLISH_TAG)
);
 
CREATE TABLE CMS_PROJECTRESOURCES (
	PROJECT_ID VARCHAR(36) NOT NULL,
	RESOURCE_PATH VARCHAR(1024),
	CONSTRAINT PK_PROJECTRESOURCES PRIMARY KEY(PROJECT_ID, RESOURCE_PATH)
);

CREATE INDEX CMS_PROJECTRESOURCES_01_IDX
	ON CMS_PROJECTRESOURCES (RESOURCE_PATH)
	;

CREATE TABLE CMS_HISTORY_PROJECTRESOURCES (
	PUBLISH_TAG INT NOT NULL,
	PROJECT_ID VARCHAR(36) NOT NULL,
	RESOURCE_PATH VARCHAR(1024),
	CONSTRAINT PK_HISTORY_PROJECTRESOURCES PRIMARY KEY(PUBLISH_TAG, PROJECT_ID, RESOURCE_PATH)
);

CREATE TABLE CMS_OFFLINE_PROPERTYDEF ( 
	PROPERTYDEF_ID VARCHAR(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR(128) NOT NULL,
	PROPERTYDEF_TYPE INT NOT NULL,
	CONSTRAINT PK_OFFLINE_PROPERTYDEF PRIMARY KEY(PROPERTYDEF_ID),
	CONSTRAINT UK_OFFLINE_PROPERTYDEF UNIQUE(PROPERTYDEF_NAME)
);

CREATE TABLE CMS_ONLINE_PROPERTYDEF ( 
	PROPERTYDEF_ID VARCHAR(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR(128) NOT NULL,
	PROPERTYDEF_TYPE INT NOT NULL,
	CONSTRAINT PK_ONLINE_PROPERTYDEF PRIMARY KEY(PROPERTYDEF_ID),
	CONSTRAINT UK_ONLINE_PROPERTYDEF UNIQUE(PROPERTYDEF_NAME) 
);

CREATE TABLE CMS_HISTORY_PROPERTYDEF ( 
	PROPERTYDEF_ID VARCHAR(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR(128) NOT NULL,
	PROPERTYDEF_TYPE INT NOT NULL,
	CONSTRAINT PK_HISTORY_PROPERTYDEF PRIMARY KEY(PROPERTYDEF_ID),
	CONSTRAINT UK_HISTORY_PROPERTYDEF UNIQUE(PROPERTYDEF_NAME)
);

 

CREATE TABLE CMS_OFFLINE_PROPERTIES (
	PROPERTY_ID VARCHAR(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR(2048) NOT NULL,
	CONSTRAINT PK_OFFLINE_PROPERTIES PRIMARY KEY(PROPERTY_ID),
	CONSTRAINT UK_OFFLINE_PROPERTIES UNIQUE(PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
);

CREATE INDEX CMS_OFFLINE_PROPERTIES_01_IDX
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID)
	;
	
CREATE INDEX CMS_OFFLINE_PROPERTIES_02_IDX
	ON CMS_OFFLINE_PROPERTIES (PROPERTY_MAPPING_ID)
	;

CREATE TABLE CMS_ONLINE_PROPERTIES (
	PROPERTY_ID VARCHAR(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR(2048) NOT NULL,
	CONSTRAINT PK_ONLINE_PROPERTIES PRIMARY KEY(PROPERTY_ID),
	CONSTRAINT UK_ONLINE_PROPERTIES UNIQUE(PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
);

CREATE INDEX CMS_ONLINE_PROPERTIES_01_IDX
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID)
	;
	
CREATE INDEX CMS_ONLINE_PROPERTIES_02_IDX
	ON CMS_ONLINE_PROPERTIES (PROPERTY_MAPPING_ID)
	;
	
CREATE TABLE CMS_HISTORY_PROPERTIES (
    STRUCTURE_ID VARCHAR(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR(2048) NOT NULL,
	PUBLISH_TAG INT,
	CONSTRAINT PK_HISTORY_PROPERTIES PRIMARY KEY(STRUCTURE_ID,PROPERTYDEF_ID,PROPERTY_MAPPING_TYPE,PUBLISH_TAG)
);

CREATE INDEX CMS_HISTORY_PROPERTIES_01_IDX
	ON CMS_HISTORY_PROPERTIES (PROPERTYDEF_ID)
	;
	
CREATE INDEX CMS_HISTORY_PROPERTIES_02_IDX
	ON CMS_HISTORY_PROPERTIES (PROPERTY_MAPPING_ID)
	;
	
CREATE INDEX CMS_HISTORY_PROPERTIES_03_IDX
	ON CMS_HISTORY_PROPERTIES (PUBLISH_TAG)
	;
	
CREATE INDEX CMS_HISTORY_PROPERTIES_04_IDX
	ON CMS_HISTORY_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
	;
	
CREATE INDEX CMS_HISTORY_PROPERTIES_05_IDX
	ON CMS_HISTORY_PROPERTIES (STRUCTURE_ID,PUBLISH_TAG)
	;
	
CREATE TABLE CMS_ONLINE_ACCESSCONTROL (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	PRINCIPAL_ID VARCHAR(36) NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	CONSTRAINT PK_ONLINE_ACCESSCONTROL PRIMARY KEY(RESOURCE_ID, PRINCIPAL_ID)
);
   
CREATE INDEX ONLINE_ACCESSCONTROL_01_IDX
	ON CMS_ONLINE_ACCESSCONTROL (PRINCIPAL_ID)
	;
	
CREATE INDEX ONLINE_ACCESSCONTROL_02_IDX
	ON CMS_ONLINE_ACCESSCONTROL (RESOURCE_ID) ; 
	
	
CREATE TABLE CMS_OFFLINE_ACCESSCONTROL (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	PRINCIPAL_ID VARCHAR(36) NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	CONSTRAINT PK_OFFLINE_ACCESSCONTROL PRIMARY KEY(RESOURCE_ID, PRINCIPAL_ID)
);

CREATE INDEX OFFLINE_ACCESSCONTROL_01_IDX
	ON CMS_OFFLINE_ACCESSCONTROL (PRINCIPAL_ID)
	;
	
CREATE INDEX OFFLINE_ACCESSCONTROL_02_IDX
	ON CMS_OFFLINE_ACCESSCONTROL (RESOURCE_ID) ;
	
CREATE TABLE CMS_PUBLISH_HISTORY (
	HISTORY_ID VARCHAR(36) NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	RESOURCE_ID VARCHAR(36) NOT NULL,
	RESOURCE_PATH VARCHAR(1024),
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	CONSTRAINT PK_PUBLISH_HISTORY PRIMARY KEY (HISTORY_ID, PUBLISH_TAG, STRUCTURE_ID, RESOURCE_PATH)
);

CREATE INDEX CMS_PUBLISH_HISTORY_01_IDX
	ON CMS_PUBLISH_HISTORY (PUBLISH_TAG)
	;
	
CREATE INDEX CMS_PUBLISH_HISTORY_02_IDX
	ON CMS_PUBLISH_HISTORY (HISTORY_ID) ;
	
CREATE TABLE CMS_PUBLISH_JOBS (
	HISTORY_ID VARCHAR(36) NOT NULL,
	PROJECT_ID VARCHAR(36) NOT NULL,
	PROJECT_NAME VARCHAR(255) NOT NULL,
	USER_ID VARCHAR(36) NOT NULL,
	PUBLISH_LOCALE VARCHAR(16) NOT NULL,
	PUBLISH_FLAGS INT NOT NULL,
	PUBLISH_LIST BYTEA,
	PUBLISH_REPORT BYTEA,
	RESOURCE_COUNT INT NOT NULL,
	ENQUEUE_TIME BIGINT NOT NULL,
	START_TIME BIGINT NOT NULL,
	FINISH_TIME BIGINT NOT NULL,
	CONSTRAINT PK_PUBLISH_JOBS PRIMARY KEY(HISTORY_ID)
);

CREATE TABLE CMS_RESOURCE_LOCKS (
  RESOURCE_PATH VARCHAR(1024),
  USER_ID VARCHAR(36) NOT NULL,
  PROJECT_ID VARCHAR(36) NOT NULL,
  LOCK_TYPE INT NOT NULL
);

CREATE INDEX CMS_RESOURCE_LOCKS_01_IDX 
	ON CMS_RESOURCE_LOCKS (RESOURCE_PATH); 

CREATE TABLE CMS_STATICEXPORT_LINKS (
	LINK_ID VARCHAR(36) NOT NULL,
	LINK_RFS_PATH VARCHAR(1024),
	LINK_TYPE INT NOT NULL,
	LINK_PARAMETER VARCHAR(1024),
	LINK_TIMESTAMP BIGINT NOT NULL,
	CONSTRAINT PK_CMS_STATICEXPORT_LINKS PRIMARY KEY (LINK_ID)
);

CREATE INDEX CMS_STATICEXPORT_LINKS_01_IDX
	ON CMS_STATICEXPORT_LINKS (LINK_RFS_PATH)
	;

CREATE TABLE CMS_OFFLINE_STRUCTURE (
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	RESOURCE_ID VARCHAR(36) NOT NULL,
	PARENT_ID VARCHAR(36) NOT NULL,
	RESOURCE_PATH VARCHAR(1024),
	STRUCTURE_STATE INT NOT NULL,	
	DATE_RELEASED BIGINT NOT NULL,
	DATE_EXPIRED BIGINT NOT NULL,	
	STRUCTURE_VERSION INT NOT NULL,
	CONSTRAINT PK_OFFLINE_STRUCTURE PRIMARY KEY (STRUCTURE_ID)
);

CREATE INDEX CMS_OFFLINE_STRUCTURE_01_IDX
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH)
	;
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_02_IDX
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_PATH, RESOURCE_ID)
	;
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_03_IDX
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_ID)
	;
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_04_IDX
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_STATE)
	;
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_05_IDX
	ON CMS_OFFLINE_STRUCTURE (PARENT_ID)
	;
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_06_IDX
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_ID)
	;
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_07_IDX
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_PATH)
	;

CREATE TABLE CMS_ONLINE_STRUCTURE (
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	RESOURCE_ID VARCHAR(36) NOT NULL,
	PARENT_ID VARCHAR(36) NOT NULL,
	RESOURCE_PATH VARCHAR(1024),
	STRUCTURE_STATE INT NOT NULL,	
	DATE_RELEASED BIGINT NOT NULL,
	DATE_EXPIRED BIGINT NOT NULL,	
	STRUCTURE_VERSION INT NOT NULL,	
	CONSTRAINT PK_ONLINE_STRUCTURE PRIMARY KEY (STRUCTURE_ID)
);

CREATE INDEX CMS_ONLINE_STRUCTURE_01_IDX
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH)
	;
	
CREATE INDEX CMS_ONLINE_STRUCTURE_02_IDX
	ON CMS_ONLINE_STRUCTURE (RESOURCE_PATH, RESOURCE_ID)
	;
	
CREATE INDEX CMS_ONLINE_STRUCTURE_03_IDX
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_ID)
	;
	
CREATE INDEX CMS_ONLINE_STRUCTURE_04_IDX
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_STATE)
	;
	
CREATE INDEX CMS_ONLINE_STRUCTURE_05_IDX
	ON CMS_ONLINE_STRUCTURE (PARENT_ID)
	;
	
CREATE INDEX CMS_ONLINE_STRUCTURE_06_IDX
	ON CMS_ONLINE_STRUCTURE (RESOURCE_ID)
	;
	
CREATE INDEX CMS_ONLINE_STRUCTURE_07_IDX
	ON CMS_ONLINE_STRUCTURE (RESOURCE_PATH)
	;

CREATE TABLE CMS_HISTORY_STRUCTURE (
    PUBLISH_TAG INT NOT NULL,
    VERSION INT NOT NULL,
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	RESOURCE_ID VARCHAR(36) NOT NULL,
	PARENT_ID VARCHAR(36) NOT NULL,
	RESOURCE_PATH VARCHAR(1024),
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED BIGINT NOT NULL,
	DATE_EXPIRED BIGINT NOT NULL,	
	STRUCTURE_VERSION INT NOT NULL,	
	CONSTRAINT PK_HISTORY_STRUCTURE PRIMARY KEY (STRUCTURE_ID,PUBLISH_TAG,VERSION)
); 

CREATE INDEX CMS_HISTORY_STRUCTURE_01_IDX
	ON CMS_HISTORY_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH)
	;
	
CREATE INDEX CMS_HISTORY_STRUCTURE_02_IDX
	ON CMS_HISTORY_STRUCTURE (RESOURCE_PATH, RESOURCE_ID)
	;
	
CREATE INDEX CMS_HISTORY_STRUCTURE_03_IDX
	ON CMS_HISTORY_STRUCTURE (STRUCTURE_ID, RESOURCE_ID)
	;
	
CREATE INDEX CMS_HISTORY_STRUCTURE_04_IDX
	ON CMS_HISTORY_STRUCTURE (STRUCTURE_STATE)
	;
	
CREATE INDEX CMS_HISTORY_STRUCTURE_05_IDX
	ON CMS_HISTORY_STRUCTURE (RESOURCE_ID)
	;
	
CREATE INDEX CMS_HISTORY_STRUCTURE_06_IDX
	ON CMS_HISTORY_STRUCTURE (RESOURCE_PATH)
	;

CREATE INDEX CMS_HISTORY_STRUCTURE_07_IDX
	ON CMS_HISTORY_STRUCTURE (PUBLISH_TAG)
	;

CREATE INDEX CMS_HISTORY_STRUCTURE_08_IDX
	ON CMS_HISTORY_STRUCTURE (VERSION)
	;
	
CREATE INDEX CMS_HISTORY_STRUCTURE_09_IDX
	ON CMS_HISTORY_STRUCTURE (STRUCTURE_ID);

CREATE TABLE CMS_OFFLINE_RESOURCES (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	DATE_CONTENT BIGINT NOT NULL,	                                         
	SIBLING_COUNT INT NOT NULL,
	DATE_CREATED BIGINT NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED VARCHAR(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR(36) NOT NULL,
	PROJECT_LASTMODIFIED VARCHAR(36) NOT NULL,
	RESOURCE_VERSION INT NOT NULL,
	CONSTRAINT PK_OFFLINE_RESOURCES PRIMARY KEY(RESOURCE_ID)
);

CREATE INDEX CMS_OFFLINE_RESOURCES_01_IDX
	ON CMS_OFFLINE_RESOURCES (PROJECT_LASTMODIFIED)
	;

CREATE INDEX CMS_OFFLINE_RESOURCES_02_IDX
	ON CMS_OFFLINE_RESOURCES (PROJECT_LASTMODIFIED, RESOURCE_SIZE)
	;

CREATE INDEX CMS_OFFLINE_RESOURCES_03_IDX
	ON CMS_OFFLINE_RESOURCES (RESOURCE_SIZE)
	;
	
CREATE INDEX CMS_OFFLINE_RESOURCES_04_IDX
	ON CMS_OFFLINE_RESOURCES (DATE_LASTMODIFIED)
	;
	
CREATE INDEX CMS_OFFLINE_RESOURCES_05_IDX
	ON CMS_OFFLINE_RESOURCES (RESOURCE_TYPE)
	;

CREATE TABLE CMS_ONLINE_RESOURCES (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	DATE_CONTENT BIGINT NOT NULL,	                                         
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED BIGINT NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED VARCHAR(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR(36) NOT NULL,
	PROJECT_LASTMODIFIED VARCHAR(36) NOT NULL,
	RESOURCE_VERSION INT NOT NULL,
	CONSTRAINT PK_ONLINE_RESOURCES PRIMARY KEY(RESOURCE_ID)
);

CREATE INDEX CMS_ONLINE_RESOURCES_01_IDX
	ON CMS_ONLINE_RESOURCES (PROJECT_LASTMODIFIED)
	;

CREATE INDEX CMS_ONLINE_RESOURCES_02_IDX
	ON CMS_ONLINE_RESOURCES (PROJECT_LASTMODIFIED, RESOURCE_SIZE)
	;

CREATE INDEX CMS_ONLINE_RESOURCES_03_IDX
	ON CMS_ONLINE_RESOURCES (RESOURCE_SIZE)
	;
	
CREATE INDEX CMS_ONLINE_RESOURCES_04_IDX
	ON CMS_ONLINE_RESOURCES (DATE_LASTMODIFIED)
	;
	
CREATE INDEX CMS_ONLINE_RESOURCES_05_IDX
	ON CMS_ONLINE_RESOURCES (RESOURCE_TYPE)
	;

CREATE TABLE CMS_HISTORY_RESOURCES (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	DATE_CONTENT BIGINT NOT NULL,	                                         
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED BIGINT NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED VARCHAR(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR(36) NOT NULL,
	PROJECT_LASTMODIFIED VARCHAR(36) NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	RESOURCE_VERSION INT NOT NULL,
	CONSTRAINT PK_HISTORY_RESOURCES PRIMARY KEY(RESOURCE_ID, PUBLISH_TAG)
);

CREATE INDEX CMS_HISTORY_RESOURCES_01_IDX
	ON CMS_HISTORY_RESOURCES (PROJECT_LASTMODIFIED)
	;
	
CREATE INDEX CMS_HISTORY_RESOURCES_02_IDX
	ON CMS_HISTORY_RESOURCES (PROJECT_LASTMODIFIED, RESOURCE_SIZE)
	;
	
CREATE INDEX CMS_HISTORY_RESOURCES_03_IDX
	ON CMS_HISTORY_RESOURCES (RESOURCE_SIZE)
	;
	
CREATE INDEX CMS_HISTORY_RESOURCES_04_IDX
	ON CMS_HISTORY_RESOURCES (DATE_LASTMODIFIED)
	;
	
CREATE INDEX CMS_HISTORY_RESOURCES_05_IDX
	ON CMS_HISTORY_RESOURCES (RESOURCE_TYPE)
	;

CREATE INDEX CMS_HISTORY_RESOURCES_06_IDX
	ON CMS_HISTORY_RESOURCES (PUBLISH_TAG)
	;
	
CREATE INDEX CMS_HISTORY_RESOURCES_07_IDX
	ON CMS_HISTORY_RESOURCES (RESOURCE_ID) ;

CREATE TABLE CMS_OFFLINE_CONTENTS (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	FILE_CONTENT BYTEA NOT NULL,
	CONSTRAINT PK_OFFLINE_CONTENTS PRIMARY KEY(RESOURCE_ID)
);

CREATE TABLE CMS_CONTENTS (
	RESOURCE_ID VARCHAR(36) NOT NULL,
	FILE_CONTENT BYTEA NOT NULL,
	PUBLISH_TAG_FROM INT,
	PUBLISH_TAG_TO INT,
	ONLINE_FLAG INT,
	CONSTRAINT PK_CONTENTS PRIMARY KEY(RESOURCE_ID, PUBLISH_TAG_FROM)
);

CREATE INDEX CMS_CONTENTS_01_IDX
	ON CMS_CONTENTS (RESOURCE_ID, PUBLISH_TAG_TO)
	;
	
CREATE INDEX CMS_CONTENTS_02_IDX
	ON CMS_CONTENTS (RESOURCE_ID)
	;
	
CREATE INDEX CMS_CONTENTS_03_IDX
	ON CMS_CONTENTS (PUBLISH_TAG_FROM)
	;
	
CREATE INDEX CMS_CONTENTS_04_IDX
	ON CMS_CONTENTS (PUBLISH_TAG_TO)
	;
	
CREATE INDEX CMS_CONTENTS_05_IDX
	ON CMS_CONTENTS (RESOURCE_ID, ONLINE_FLAG)
	;

CREATE TABLE CMS_ONLINE_RESOURCE_RELATIONS (
	RELATION_SOURCE_ID VARCHAR(36) NOT NULL,
	RELATION_SOURCE_PATH VARCHAR(1024) NOT NULL,
	RELATION_TARGET_ID VARCHAR(36) NOT NULL,
	RELATION_TARGET_PATH VARCHAR(1024) NOT NULL,
	RELATION_TYPE INT NOT NULL
);

CREATE INDEX CMS_ONLINE_RELATIONS_01_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_SOURCE_ID)
	;
	
CREATE INDEX CMS_ONLINE_RELATIONS_02_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_TARGET_ID)
	;
	
CREATE INDEX CMS_ONLINE_RELATIONS_03_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_SOURCE_PATH)
	;
	
CREATE INDEX CMS_ONLINE_RELATIONS_04_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_TARGET_PATH)
	;

CREATE INDEX CMS_ONLINE_RELATIONS_05_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_TYPE)
	;

CREATE TABLE CMS_OFFLINE_RESOURCE_RELATIONS (
	RELATION_SOURCE_ID VARCHAR(36) NOT NULL,
	RELATION_SOURCE_PATH VARCHAR(1024) NOT NULL,
	RELATION_TARGET_ID VARCHAR(36) NOT NULL,
	RELATION_TARGET_PATH VARCHAR(1024) NOT NULL,
	RELATION_TYPE INT NOT NULL
);

CREATE INDEX CMS_OFFLINE_RELATIONS_01_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_SOURCE_ID)
	;
	
CREATE INDEX CMS_OFFLINE_RELATIONS_02_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_TARGET_ID)
	;
	
CREATE INDEX CMS_OFFLINE_RELATIONS_03_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_SOURCE_PATH)
	;

CREATE INDEX CMS_OFFLINE_RELATIONS_04_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_TARGET_PATH)
	;
	
CREATE INDEX CMS_OFFLINE_RELATIONS_05_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_TYPE)
	;

CREATE TABLE CMS_LOG (
    USER_ID VARCHAR(36) NOT NULL,
    LOG_DATE BIGINT NOT NULL,
    STRUCTURE_ID VARCHAR(36) NOT NULL,
    LOG_TYPE INT NOT NULL,
    LOG_DATA VARCHAR(1024),
    CONSTRAINT PK_LOG PRIMARY KEY (USER_ID, LOG_DATE, LOG_TYPE, STRUCTURE_ID)
);

CREATE INDEX CMS_LOG_01_IDX 
    ON CMS_LOG (USER_ID)
    ;

CREATE INDEX CMS_LOG_02_IDX 
    ON CMS_LOG (LOG_DATE)
    ;

CREATE INDEX CMS_LOG_03_IDX 
    ON CMS_LOG (STRUCTURE_ID)
    ;

CREATE INDEX CMS_LOG_04_IDX 
    ON CMS_LOG (LOG_TYPE)
    ;

CREATE INDEX CMS_LOG_05_IDX 
    ON CMS_LOG (USER_ID, STRUCTURE_ID)
    ;

CREATE INDEX CMS_LOG_06_IDX 
    ON CMS_LOG (USER_ID, LOG_DATE)
    ;

CREATE INDEX CMS_LOG_07_IDX 
    ON CMS_LOG (USER_ID, STRUCTURE_ID, LOG_DATE)
    ;

CREATE INDEX CMS_LOG_08_IDX 
    ON CMS_LOG (USER_ID, LOG_TYPE, STRUCTURE_ID, LOG_DATE)
    ;
    
CREATE INDEX CMS_LOG_09_IDX
	ON CMS_LOG (USER_ID, LOG_DATE, LOG_TYPE)
	;
    
    
CREATE TABLE CMS_SUBSCRIPTION_VISIT (
    USER_ID VARCHAR(36) NOT NULL,
    VISIT_DATE BIGINT NOT NULL,
    STRUCTURE_ID VARCHAR(36),
    CONSTRAINT PK_VISIT PRIMARY KEY (USER_ID, VISIT_DATE)
);

CREATE INDEX CMS_SUBSCRIPTION_VISIT_01_IDX 
    ON CMS_SUBSCRIPTION_VISIT (USER_ID)
    ;

CREATE INDEX CMS_SUBSCRIPTION_VISIT_02_IDX 
    ON CMS_SUBSCRIPTION_VISIT (VISIT_DATE)
    ;

CREATE INDEX CMS_SUBSCRIPTION_VISIT_03_IDX 
    ON CMS_SUBSCRIPTION_VISIT (STRUCTURE_ID)
    ;


CREATE INDEX CMS_SUBSCRIPTION_VISIT_04_IDX 
    ON CMS_SUBSCRIPTION_VISIT (USER_ID, STRUCTURE_ID)
    ;

CREATE INDEX CMS_SUBSCRIPTION_VISIT_05_IDX 
    ON CMS_SUBSCRIPTION_VISIT (USER_ID, VISIT_DATE)
    ;

CREATE INDEX CMS_SUBSCRIPTION_VISIT_06_IDX 
    ON CMS_SUBSCRIPTION_VISIT (USER_ID, STRUCTURE_ID, VISIT_DATE)
    ;

CREATE TABLE CMS_SUBSCRIPTION (
    PRINCIPAL_ID VARCHAR(36) NOT NULL,
    STRUCTURE_ID VARCHAR(36) NOT NULL,
    DATE_DELETED BIGINT NOT NULL,
   CONSTRAINT PK_SUBSCRIPTION PRIMARY KEY (PRINCIPAL_ID, STRUCTURE_ID)
);

CREATE INDEX CMS_SUBSCRIPTION_01_IDX 
    ON CMS_SUBSCRIPTION (PRINCIPAL_ID)
    ;

CREATE INDEX CMS_SUBSCRIPTION_02_IDX 
    ON CMS_SUBSCRIPTION (STRUCTURE_ID)
    ;

CREATE INDEX CMS_SUBSCRIPTION_03_IDX 
    ON CMS_SUBSCRIPTION (DATE_DELETED)
    ;

CREATE INDEX CMS_SUBSCRIPTION_04_IDX 
    ON CMS_SUBSCRIPTION (PRINCIPAL_ID, STRUCTURE_ID, DATE_DELETED) 
    ;
    
CREATE TABLE CMS_COUNTERS (
	NAME VARCHAR(255) NOT NULL,
	COUNTER INT NOT NULL,
	CONSTRAINT PK_COUNTERS PRIMARY KEY (NAME)
);


CREATE TABLE CMS_OFFLINE_URLNAME_MAPPINGS (
	NAME VARCHAR(255) NOT NULL,
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	STATE INT NOT NULL,
	DATE_CHANGED BIGINT NOT NULL,
	LOCALE VARCHAR(10)
);

CREATE INDEX CMS_OFFLINE_URLNAME_MAPPINGS_01_IDX
	ON CMS_OFFLINE_URLNAME_MAPPINGS (NAME);
	
CREATE INDEX CMS_OFFLINE_URLNAME_MAPPINGS_02_IDX
	ON CMS_OFFLINE_URLNAME_MAPPINGS (STRUCTURE_ID);


CREATE TABLE CMS_ONLINE_URLNAME_MAPPINGS (
	NAME VARCHAR(255) NOT NULL,
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	STATE INT NOT NULL,
	DATE_CHANGED BIGINT NOT NULL,
	LOCALE VARCHAR(10)
);

CREATE INDEX CMS_ONLINE_URLNAME_MAPPINGS_01_IDX
	ON CMS_ONLINE_URLNAME_MAPPINGS (NAME);
	
CREATE INDEX CMS_ONLINE_URLNAME_MAPPINGS_02_IDX
	ON CMS_ONLINE_URLNAME_MAPPINGS (STRUCTURE_ID);










