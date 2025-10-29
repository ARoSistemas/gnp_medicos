library constants;

//---ALERT POLIZAS GMM----
const String ALERTA_NOTIFICATION_POLIZA_GMM = "Recuerda que tu participación de coaseguro varía dependiendo del niivel hospitalario donde recibas la atención médica. Consulta a tu agente o llama a la Línea GNP 55 5227 9000.";
const String ALERTA_WARNING_POLIZA_GMM = "El deducible y coaseguro dependerán del nivel hospitalario donde recibas la atención médica. Consulta a tu Agente o llama a la Línea GNP.";
const String ALERTA_OFF_POLIZA_GMM = "Recuerda que tu participación puede variar al atenderte en un hospital de mayor nivel al contratado. Consulta a tu Agente o llama a la Línea GNP.";
const String ALERTA_NOTIFICATION_POLIZA_GMM_TITULO = "Beneficio";
const String ALERTA_WARNING_POLIZA_GMM_TITULO = "Penalización";
const String ALERTA_OFF_POLIZA_GMM_TITULO ="Participación en el caso";

const String ALERTA_NO_CONEXION = "Verifica tu conexión a internet e inténtalo nuevamente.";

const String getHospitales = "/redesMedicas/catalogo/hospitales?origen=intermediarios";
const String getMedicos = "/redesMedicas/catalogo/medicos";
const String getModulos = "/redesMedicas/catalogo/modulos";
const String getClinicas = "/redesMedicas/catalogo/clinicas";
const String getSauxs = "/redesMedicas/catalogo/sauxs";
const String getPlanes = "/redesMedicas/catalogo/planes";
const String getCirculoM = "/redesMedicas/catalogo/circuloMedico";
const String getEspecialidad = "/redesMedicas/catalogo/especialidad";
const String getSubEspecialidad = "/redesMedicas/catalogo/subespecialidad";
const String getTiposServicio = "/redesMedicas/catalogo/tiposServicio";
const String getTiposClinica = "/redesMedicas/catalogo/tiposClinica";
const String getEstados = "/redesMedicas/catalogo/estados";
const String getMunicipios = "/redesMedicas/catalogo/municipios/estado/";
//const String nivelHospitalario = "/redesMedicas/catalogo/nivelesHospitalarios";
const String nivelHospitalario = "integracion/catalogo/nivelHospitalario";
const String productosComerciales = "/redesMedicas/catalogo/productosComerciales";
const String apiDistance = "/directions/json?";
const String apiPlace = "/place/nearbysearch/json?location=";
const String apiclient = "integracion/client/analytics";
const String busquedaPorNombre  = "/busquedapred/busqueda";
const String busquedaPorCliente  = "/crm-agente/consulta-cartera-cliente";
const String busquedaPorPoliza  = "/crm-agente/consulta-cartera-poliza";

const String getTiposClinicas = 'integracion/catalogo/tiposClinica';
const String listaNuevaClinica = "msv-programacion-servicio/admonproveedores/lista";

const String catalogoClinicas = 'integracion/catalogo/clinicas';