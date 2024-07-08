import clientPostgres from '@resource/postgresClient';
import { isEncoded } from '@util/requestValidator';
import winstonLogger from '@util/winstonLogger';
import { DataTypes, ModelAttributes, ModelOptions, Sequelize } from 'sequelize';
import config from '@/config';

export const sequelize: Sequelize = new Sequelize(clientPostgres.pgURL, {
  dialect: 'postgres',
  logging:
    config.APPLICATION_CONFIG.nodeEnv === 'production'
      ? false
      : (sql: string): void => {
          winstonLogger.debug(sql);
        },
});

export const commonSettings: ModelOptions = {
  freezeTableName: true,
  timestamps: false,
};

export const AOEUser = <AOEUserType>sequelize.define(
  'aoeuser',
  {
    username: {
      field: 'username',
      type: DataTypes.STRING(255),
      primaryKey: true,
      allowNull: false,
    },
  } as ModelAttributes<AOEUser, unknown>,
  commonSettings as ModelOptions,
);

export const EducationalMaterial = <EducationalMaterialType>sequelize.define(
  'educationalmaterial',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    createdAt: {
      field: 'createdat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    publishedAt: {
      field: 'publishedat',
      type: DataTypes.DATE,
      allowNull: true,
    },
    updatedAt: {
      field: 'updatedat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    archivedAt: {
      field: 'archivedat',
      type: DataTypes.DATE,
      allowNull: true,
    },
    timeRequired: {
      field: 'timerequired',
      type: DataTypes.TEXT,
      allowNull: false,
      defaultValue: '',
    },
    ageRangeMin: {
      field: 'agerangemin',
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    ageRangeMax: {
      field: 'agerangemax',
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    licenseCode: {
      field: 'licensecode',
      type: DataTypes.TEXT,
      allowNull: false,
      defaultValue: '',
    },
    obsoleted: {
      field: 'obsoleted',
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    originalPublishedAt: {
      field: 'originalpublishedat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    usersUserName: {
      field: 'usersusername',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    expires: {
      field: 'expires',
      type: DataTypes.DATE,
      allowNull: true,
    },
    suitsAllEarlyChildhoodSubjects: {
      field: 'suitsallearlychildhoodsubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllPreprimarySubjects: {
      field: 'suitsallpreprimarysubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllBasicStudySubjects: {
      field: 'suitsallbasicstudysubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllUpperSecondarySubjects: {
      field: 'suitsalluppersecondarysubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllVocationalDegrees: {
      field: 'suitsallvocationaldegrees',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllSelfmotivatedSubjects: {
      field: 'suitsallselfmotivatedsubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllBranches: {
      field: 'suitsallbranches',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllUpperSecondarySubjectsNew: {
      field: 'suitsalluppersecondarysubjectsnew',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    ratingContentAverage: {
      field: 'ratingcontentaverage',
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    ratingVisualAverage: {
      field: 'ratingvisualaverage',
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    viewCounter: {
      field: 'viewcounter',
      type: DataTypes.BIGINT,
      allowNull: true,
      defaultValue: 0,
    },
    downloadCounter: {
      field: 'downloadcounter',
      type: DataTypes.BIGINT,
      allowNull: true,
      defaultValue: 0,
    },
    counterUpdatedAt: {
      field: 'counterupdatedat',
      type: DataTypes.DATE,
      allowNull: true,
    },
  } as ModelAttributes<EducationalMaterial, unknown>,
  commonSettings as ModelOptions,
);

export const Material = <MaterialType>sequelize.define(
  'material',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    link: {
      field: 'link',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    educationalMaterialId: {
      field: 'educationalmaterialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: EducationalMaterial, // Can be the table name 'educationalmaterial' or the Sequelize model EducationalMaterial
        key: 'id',
      },
    },
    obsoleted: {
      field: 'obsoleted',
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    priority: {
      field: 'priority',
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    materialLanguageKey: {
      field: 'materiallanguagekey',
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  } as ModelAttributes<Material, unknown>,
  commonSettings as ModelOptions,
);

export const MaterialDisplayName = <MaterialDisplayNameType>sequelize.define(
  'materialdisplayname',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    displayName: {
      field: 'displayname',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    language: {
      field: 'language',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    materialId: {
      field: 'materialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: Material, // Can be the table name 'material' or the Sequelize model Material
        key: 'id',
      },
    },
  } as ModelAttributes<MaterialDisplayName, unknown>,
  commonSettings as ModelOptions,
);

export const Notification = <NotificationType>sequelize.define(
  'notification',
  {
    id: {
      field: 'nf_id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    text: {
      field: 'nf_text',
      type: DataTypes.STRING(1500),
      allowNull: false,
    },
    type: {
      field: 'nf_type',
      type: DataTypes.STRING,
      validate: {
        isIn: {
          args: [['ERROR', 'INFO']],
        },
      },
      allowNull: false,
    },
    createdAt: {
      field: 'nf_created_at',
      type: DataTypes.DATE,
      allowNull: true,
    },
    showSince: {
      field: 'nf_show_since',
      type: DataTypes.DATE,
      allowNull: true,
    },
    showUntil: {
      field: 'nf_show_until',
      type: DataTypes.DATE,
      allowNull: true,
    },
    disabled: {
      field: 'nf_disabled',
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    username: {
      field: 'nf_username',
      type: DataTypes.STRING(255),
      allowNull: false,
      references: {
        model: AOEUser,
        key: 'username',
      },
      onUpdate: 'CASCADE',
      onDelete: 'NO ACTION',
    },
  } as ModelAttributes<Notification, unknown>,
  {
    hooks: {
      beforeCreate: (notification: Notification): void => {
        if (!isEncoded(notification.text)) {
          notification.text = encodeURIComponent(notification.text);
        }
      },
      beforeValidate: (notification: Notification): void => {
        notification.text = decodeURIComponent(notification.text);
      },
    },
    ...commonSettings,
  } as ModelOptions,
  // commonSettings as ModelOptions,
);

export const Record = <RecordType>sequelize.define(
  'record',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    filePath: {
      field: 'filepath',
      type: DataTypes.TEXT,
      allowNull: true,
    },
    originalFileName: {
      field: 'originalfilename',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    fileSize: {
      field: 'filesize',
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    mimeType: {
      field: 'mimetype',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    materialId: {
      field: 'materialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: Material, // Can be the table name 'material' or the Sequelize model Material
        key: 'id',
      },
    },
    fileKey: {
      field: 'filekey',
      type: DataTypes.TEXT,
      allowNull: true,
    },
    fileBucket: {
      field: 'filebucket',
      type: DataTypes.TEXT,
      allowNull: true,
    },
    pdfKey: {
      field: 'pdfkey',
      type: DataTypes.TEXT,
      allowNull: true,
    },
  } as ModelAttributes<IRecord, unknown>,
  commonSettings as ModelOptions,
);

export const TemporaryRecord = <TemporaryRecordType>sequelize.define(
  'temporaryrecord',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    filePath: {
      field: 'filepath',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    originalFileName: {
      field: 'originalfilename',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    fileSize: {
      field: 'filesize',
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    mimeType: {
      field: 'mimetype',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    fileName: {
      field: 'filename',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    materialId: {
      field: 'materialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: Material, // Can be the table name 'material' or the Sequelize model Material
        key: 'id',
      },
    },
    createdAt: {
      field: 'createdat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  } as ModelAttributes<TemporaryRecord, unknown>,
  commonSettings as ModelOptions,
);

// AOEUser <=> Notification
AOEUser.hasMany(Notification, {
  foreignKey: 'username',
});
Notification.belongsTo(AOEUser, {
  foreignKey: 'username',
});

// EducationalMaterial <=> Material
EducationalMaterial.hasMany(Material, {
  foreignKey: 'educationalMaterialId',
  as: 'materials',
});
Material.belongsTo(EducationalMaterial, {
  foreignKey: 'educationalMaterialId',
});

// Material <=> MaterialDisplayName
Material.hasMany(MaterialDisplayName, {
  foreignKey: 'materialId',
  as: 'materialDisplayNames',
});
MaterialDisplayName.belongsTo(Material, {
  foreignKey: 'materialId',
});
