DROP TABLE IF EXISTS EducationalMaterialCollectionEducationalMaterial CASCADE;
DROP TABLE IF EXISTS UsersEducationalMaterialCollection CASCADE;
DROP TABLE IF EXISTS IsBasedOn CASCADE;
DROP TABLE IF EXISTS EducationalUse CASCADE;
DROP TABLE IF EXISTS Record CASCADE;
DROP TABLE IF EXISTS CollectionEducationalUse CASCADE;
DROP TABLE IF EXISTS CollectionAlignmentObject CASCADE;
DROP TABLE IF EXISTS CollectionEducationalFramework CASCADE;
DROP TABLE IF EXISTS CollectionTopic CASCADE;
DROP TABLE IF EXISTS CollectionEducationalLevel CASCADE;
DROP TABLE IF EXISTS CollectionEducationalAudience CASCADE;
DROP TABLE IF EXISTS CollectionLanguage CASCADE;
DROP TABLE IF EXISTS CollectionKeyWord CASCADE;
DROP TABLE IF EXISTS EducationalMaterialCollection CASCADE;
DROP TABLE IF EXISTS KeyWord CASCADE;
DROP TABLE IF EXISTS EducationalLevel CASCADE;
-- DROP TABLE IF EXISTS AccessibilityControl CASCADE;
-- DROP TABLE IF EXISTS AccessibilityAPI CASCADE;
DROP TABLE IF EXISTS AccessibilityHazard CASCADE;
DROP TABLE IF EXISTS AccessibilityFeature CASCADE;
DROP TABLE IF EXISTS EducationalRole CASCADE;
DROP TABLE IF EXISTS LearningResourceType CASCADE;
DROP TABLE IF EXISTS AlignmentObject CASCADE;
DROP TABLE IF EXISTS InLanguage CASCADE;
DROP TABLE IF EXISTS License CASCADE;
DROP TABLE IF EXISTS EducationalAudience CASCADE;
DROP TABLE IF EXISTS Material CASCADE;
DROP TABLE IF EXISTS EducationalMaterial CASCADE;
DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS Publisher CASCADE;
DROP TABLE IF EXISTS MaterialName CASCADE;
DROP TABLE IF EXISTS MaterialDescription CASCADE;
DROP TABLE IF EXISTS Author CASCADE;
DROP TABLE IF EXISTS MaterialDisplayName CASCADE;
DROP TABLE IF EXISTS TemporaryRecord CASCADE;
DROP TABLE IF EXISTS Thumbnail CASCADE;
DROP TABLE IF EXISTS Prerequisites CASCADE;

CREATE TYPE lang AS ENUM ('fi', 'en', 'sv');

CREATE TABLE Users (
  Id                      BIGSERIAL NOT NULL, 
  FirstName              text NOT NULL, 
  LastName               text NOT NULL, 
  UserName               text NOT NULL, 
  PreferredLanguage      lang DEFAULT 'fi' NOT NULL, 
  PreferredTargetName    text NOT NULL, 
  PreferredAlignmentType text NOT NULL,
  TermsOfUsage           bool DEFAULT '0' NOT NULL,  
  PRIMARY KEY (UserName));

CREATE TABLE EducationalMaterial (
  Id                   BIGSERIAL NOT NULL, 
  CreatedAt           timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL, 
  PublishedAt         timestamp with time zone, 
  UpdatedAt           timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL, 
  ArchivedAt          timestamp with time zone, 
  --TechnicalName       text DEFAULT '' NOT NULL, 
  TimeRequired        text DEFAULT '' NOT NULL, 
  AgeRangeMin         int4 DEFAULT -1 NOT NULL, 
  AgeRangeMax         int4 DEFAULT -1 NOT NULL,
  LicenseCode         text DEFAULT '' NOT NULL, 
  Obsoleted           int4 DEFAULT 0 NOT NULL,
  OriginalPublishedAt timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL, 
  UsersUserName       text NOT NULL,
  Expires             timestamp with time zone, 
  SuitsAllEarlyChildhoodSubjects bool DEFAULT 'false' NOT NULL, 
  SuitsAllPrePrimarySubjects     bool DEFAULT 'false' NOT NULL, 
  SuitsAllBasicStudySubjects     bool DEFAULT 'false' NOT NULL, 
  SuitsAllUpperSecondarySubjects bool DEFAULT 'false' NOT NULL, 
  SuitsAllVocationalDegrees      bool DEFAULT 'false' NOT NULL, 
  SuitsAllSelfMotivatedSubjects  bool DEFAULT 'false' NOT NULL, 
  SuitsAllBranches               bool DEFAULT 'false' NOT NULL,
  PRIMARY KEY (Id));


CREATE TABLE Material (
  Id                     BIGSERIAL NOT NULL, 
  Link                  text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  Obsoleted             int4 DEFAULT 0 NOT NULL, 
  Priority              int4 DEFAULT 0 NOT NULL, 
  MaterialLanguage      text DEFAULT '' NOT NULL, 
  MaterialLanguageKey   lang DEFAULT 'fi' NOT NULL, 
  PRIMARY KEY (Id));


 CREATE TABLE EducationalAudience (
  Id                     BIGSERIAL NOT NULL, 
  EducationalRole       text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  EducationalRoleKey    text NOT NULL, 
  PRIMARY KEY (Id));

CREATE TABLE InLanguage (
  Id                     BIGSERIAL NOT NULL, 
  InLanguage            text NOT NULL, 
  Url                   text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE AlignmentObject (
  Id                     BIGSERIAL NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  AlignmentType         text NOT NULL, 
  TargetName            text NOT NULL, 
  Source                text NOT NULL, 
  EducationalFramework  text DEFAULT '' NOT NULL, 
  ObjectKey             text NOT NULL, 
  TargetUrl             text NOT NULL,
  PRIMARY KEY (Id));

CREATE TABLE LearningResourceType (
  Id                       BIGSERIAL NOT NULL, 
  Value                   text NOT NULL, 
  EducationalMaterialId   int8 NOT NULL, 
  LearningResourceTypeKey text, 
  PRIMARY KEY (Id));
-- CREATE TABLE AccessibilityControl (
--   Id                     BIGSERIAL NOT NULL, 
--   Value                 text NOT NULL, 
--   EducationalMaterialId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE AccessibilityAPI (
--   Id                     BIGSERIAL NOT NULL, 
--   Value                 text NOT NULL, 
--   EducationalMaterialId int8 NOT NULL, 
--   PRIMARY KEY (Id));
CREATE TABLE AccessibilityHazard (
  Id                      BIGSERIAL NOT NULL, 
  Value                  text NOT NULL, 
  EducationalMaterialId  int8 NOT NULL, 
  AccessibilityHazardKey text NOT NULL, 
  PRIMARY KEY (Id));

CREATE TABLE AccessibilityFeature (
  Id                       BIGSERIAL NOT NULL, 
  Value                   text NOT NULL, 
  EducationalMaterialId   int8 NOT NULL, 
  AccessibilityFeatureKey text NOT NULL, 
  PRIMARY KEY (Id));

 CREATE TABLE EducationalLevel (
  Id                     BIGSERIAL NOT NULL, 
  Value                 text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  EducationalLevelKey   text NOT NULL, 
  PRIMARY KEY (Id));

CREATE TABLE KeyWord (
  Id                     BIGSERIAL NOT NULL, 
  Value                 text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  KeywordKey            text NOT NULL, 
  PRIMARY KEY (Id));
-- CREATE TABLE EducationalMaterialCollection (
--   Id             BIGSERIAL NOT NULL, 
--   Name          text NOT NULL, 
--   Type          text NOT NULL, 
--   CreationDate  date NOT NULL, 
--   Description   text NOT NULL, 
--   CreatedBy     text NOT NULL, 
--   TechnicalName text NOT NULL, 
--   AgeRangeMin   int4 DEFAULT 0 NOT NULL, 
--   AgeRangeMax   int4 DEFAULT 99 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionKeyWord (
--   Id                               BIGSERIAL NOT NULL, 
--   Value                           text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionLanguage (
--   Id                               BIGSERIAL NOT NULL, 
--   Language                        text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionEducationalAudience (
--   Id                               BIGSERIAL NOT NULL, 
--   Audience                        text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionEducationalLevel (
--   Id                               BIGSERIAL NOT NULL, 
--   EducationalLevel                text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionTopic (
--   Id                               BIGSERIAL NOT NULL, 
--   Topic                           text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionEducationalFramework (
--   Id                               BIGSERIAL NOT NULL, 
--   Framework                       text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionAlignmentObject (
--   Id                               BIGSERIAL NOT NULL, 
--   AlignmentType                    text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
-- CREATE TABLE CollectionEducationalUse (
--   Id                               BIGSERIAL NOT NULL, 
--   EducationalUse                  text NOT NULL, 
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   PRIMARY KEY (Id));
CREATE TABLE Record (
  Id                BIGSERIAL NOT NULL, 
  FilePath         text NOT NULL, 
  OriginalFileName text NOT NULL, 
  FileSize         int4 NOT NULL, 
  MimeType         text NOT NULL, 
  Format           text NOT NULL, 
  MaterialId       int8 NOT NULL, 
  FileKey          text NOT NULL, 
  FileBucket       text NOT NULL, 
  PRIMARY KEY (Id));

 CREATE TABLE EducationalUse (
  Id                     BIGSERIAL NOT NULL, 
  Value                 text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  EducationalUseKey     text NOT NULL, 
  PRIMARY KEY (Id));

CREATE TABLE IsBasedOn (
  Id                     BIGSERIAL NOT NULL, 
  Author                text NOT NULL, 
  Url                   text NOT NULL, 
  MaterialName          text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  PRIMARY KEY (Id));
-- CREATE TABLE UsersEducationalMaterialCollection (
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   UsersUserName                   text NOT NULL, 
--   PRIMARY KEY (EducationalMaterialCollectionId, 
--   UsersUserName));
-- CREATE TABLE EducationalMaterialCollectionEducationalMaterial (
--   EducationalMaterialCollectionId int8 NOT NULL, 
--   EducationalMaterialId           int8 NOT NULL, 
--   PRIMARY KEY (EducationalMaterialCollectionId, 
--   EducationalMaterialId));
CREATE TABLE Publisher (
  Id                     BIGSERIAL NOT NULL, 
  Name                  text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  PublisherKey          text NOT NULL, 
  PRIMARY KEY (Id));

CREATE TABLE MaterialDescription (
  Id                     BIGSERIAL NOT NULL, 
  Description           text NOT NULL, 
  Language              lang NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE MaterialName (
  Id                     BIGSERIAL NOT NULL, 
  MaterialName          text DEFAULT '' NOT NULL, 
  Language              lang NOT NULL, 
  Slug                  text DEFAULT '' NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  PRIMARY KEY (Id));

 CREATE TABLE Author (
  Id                     BIGSERIAL NOT NULL, 
  authorname            text NOT NULL, 
  organization          text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  organizationkey       text NOT NULL, 
  PRIMARY KEY (Id));

  CREATE TABLE MaterialDisplayName (
  Id           BIGSERIAL NOT NULL, 
  DisplayName text NOT NULL, 
  Language    lang NOT NULL, 
  MaterialId  int8 NOT NULL, 
--  Slug        text NOT NULL, 
  PRIMARY KEY (Id));

  CREATE TABLE temporaryrecord (
  Id                BIGSERIAL NOT NULL, 
  FilePath         text NOT NULL, 
  OriginalFileName text NOT NULL, 
  Filesize         int4 NOT NULL, 
  Mimetype         text NOT NULL, 
  Format           text NOT NULL, 
  FileName         text NOT NULL, 
  MaterialId       int8 NOT NULL, 
  CreatedAt        timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL, 
  PRIMARY KEY (Id));

CREATE TABLE Thumbnail (
  Id                     BIGSERIAL NOT NULL, 
  FilePath              text NOT NULL, 
  MimeType              text NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  FileName              text NOT NULL, 
  Obsoleted             int4 DEFAULT 0 NOT NULL, 
  FileKey               text NOT NULL, 
  FileBucket            text NOT NULL, 
  PRIMARY KEY (Id));



ALTER TABLE AlignmentObject ADD CONSTRAINT FKAlignmentObject FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE EducationalMaterial ADD CONSTRAINT FKEducationalMaterial FOREIGN KEY (UsersUserName) REFERENCES Users (UserName) ON DELETE Restrict;
ALTER TABLE EducationalAudience ADD CONSTRAINT FKEducationalAudience FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE LearningResourceType ADD CONSTRAINT FKLearningResourceType FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE KeyWord ADD CONSTRAINT FKKeyWord FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE EducationalUse ADD CONSTRAINT FKEducationalUse FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE IsBasedOn ADD CONSTRAINT FKIsBasedOn FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE InLanguage ADD CONSTRAINT FKInLanguage FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE Material ADD CONSTRAINT FKMaterial FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Restrict;
ALTER TABLE Record ADD CONSTRAINT FKRecord FOREIGN KEY (MaterialId) REFERENCES Material (Id) ON DELETE Restrict;
-- ALTER TABLE CollectionKeyWord ADD CONSTRAINT FKCollectionKeyWord FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionLanguage ADD CONSTRAINT FKCollectionLanguage FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionEducationalAudience ADD CONSTRAINT FKCollectionEducationalAudience FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionEducationalLevel ADD CONSTRAINT FKCollectionEducationalLevel FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionTopic ADD CONSTRAINT FKCollectionTopic FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionEducationalFramework ADD CONSTRAINT FKCollectionEducationalFramework FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionAlignmentObject ADD CONSTRAINT FKCollectionAlignmentObject FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE CollectionEducationalUse ADD CONSTRAINT fk_CollectionEducationalUse FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE UsersEducationalMaterialCollection ADD CONSTRAINT fk_UsersEMC FOREIGN KEY (UsersUserName) REFERENCES Users (username) ON DELETE Restrict;
-- ALTER TABLE UsersEducationalMaterialCollection ADD CONSTRAINT fk_EMCUsers FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE EducationalMaterialCollectionEducationalMaterial ADD CONSTRAINT fk_EMCMaterial FOREIGN KEY (EducationalMaterialCollectionId) REFERENCES EducationalMaterialCollection (Id) ON DELETE Cascade;
-- ALTER TABLE EducationalMaterialCollectionEducationalMaterial ADD CONSTRAINT fk_MaterialEMC FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Restrict;
ALTER TABLE EducationalLevel ADD CONSTRAINT fk_EducationalLevel FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE Publisher ADD CONSTRAINT fk_Publisher FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE MaterialDescription ADD CONSTRAINT fk_Description FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE MaterialName ADD CONSTRAINT fk_MaterialName FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE AccessibilityFeature ADD CONSTRAINT fk_AccessibilityFeature FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE AccessibilityHazard ADD CONSTRAINT fk_AccessibilityHazard FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
-- ALTER TABLE AccessibilityAPI ADD CONSTRAINT fk_AccessibilityAPI FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);
-- ALTER TABLE AccessibilityControl ADD CONSTRAINT fk_AccessibilityControl FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);
ALTER TABLE Author ADD CONSTRAINT fk_author FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Cascade;
ALTER TABLE MaterialDisplayName ADD CONSTRAINT fk_MaterialDisplayName FOREIGN KEY (MaterialId) REFERENCES Material (Id) ON DELETE Cascade;
-- ALTER TABLE temporaryrecord ADD CONSTRAINT fk_temporaryrecord FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);
ALTER TABLE temporaryrecord ADD CONSTRAINT fk_temporaryrecord FOREIGN KEY (MaterialId) REFERENCES Material (Id) ON DELETE Restrict;
ALTER TABLE Thumbnail ADD CONSTRAINT fk_thumbnail FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Restrict;

ALTER TABLE materialname ADD CONSTRAINT constraint_lang_id UNIQUE (language,educationalmaterialid);
ALTER TABLE materialdescription ADD CONSTRAINT constraint_materialdescription_lang_id UNIQUE (language,educationalmaterialid);
ALTER TABLE educationalaudience ADD CONSTRAINT constraint_educationalaudience UNIQUE (educationalrolekey,educationalmaterialid);
ALTER TABLE educationaluse ADD CONSTRAINT constraint_educationaluse UNIQUE (educationalusekey,educationalmaterialid);
ALTER TABLE learningresourcetype ADD CONSTRAINT constraint_learningresourcetype UNIQUE (learningresourcetypekey,educationalmaterialid);
ALTER TABLE inlanguage ADD CONSTRAINT constraint_inlanguage UNIQUE (inlanguage,educationalmaterialid);
ALTER TABLE keyword ADD CONSTRAINT constraint_keyword UNIQUE (keywordkey,educationalmaterialid);
ALTER TABLE publisher ADD CONSTRAINT constraint_publisher UNIQUE (PublisherKey,educationalmaterialid);
ALTER TABLE isbasedon ADD CONSTRAINT constraint_isbasedon UNIQUE (author, materialname,educationalmaterialid);
ALTER TABLE alignmentobject ADD CONSTRAINT constraint_alignmentobject UNIQUE (alignmentType, targetName, source, educationalmaterialid);
ALTER TABLE materialdisplayname ADD CONSTRAINT constraint_materialdisplayname UNIQUE (language, materialid);
-- ALTER TABLE thumbnail ADD CONSTRAINT constraint_thumbnail UNIQUE (educationalmaterialid);
ALTER TABLE accessibilityfeature ADD CONSTRAINT constraint_accessibilityfeature UNIQUE (accessibilityfeaturekey,educationalmaterialid);
ALTER TABLE accessibilityhazard ADD CONSTRAINT constraint_accessibilityhazard UNIQUE (accessibilityhazardkey,educationalmaterialid);
ALTER TABLE EducationalLevel ADD CONSTRAINT constraint_EducationalLevel UNIQUE (EducationalLevelKey,educationalmaterialid);