const pool = require("../database/mysql");

module.exports.getAllEtudiants = async (req, res) => {
    try{
     /* const { id } = req.body;
     console.log(req.body);
     console.log(id);
      */
         const data = await pool.query('SELECT * FROM v_etudiants');
        if (data[0].length === 0) {
            console.log("admin not found");
            return res.status(404).json({ error: 'admin not found' });
        }
        const admin = data[0];
        
        res.status(200).json(admin);
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Admin not connected' });
    }  
};
module.exports.getDashboard = async (req, res) => {
    try{
     /* const { id } = req.body;
     console.log(req.body);
     console.log(id);
      */
         const data = await pool.query("SELECT * FROM v_dashboard_home");
        if (data[0].length === 0) {
            console.log("admin not found");
            return res.status(404).json({ error: 'admin not found' });
        }

const recents_etudiants = JSON.parse(data[0][0].recents_etudiants);
        const total_etudiants = data[0][0].total_etudiants;
        const inscrits_ce_mois = data[0][0].inscrits_ce_mois;
        
        res.status(200).json({total_etudiants,inscrits_ce_mois, recents_etudiants});
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Admin not connected' });
    }  
};